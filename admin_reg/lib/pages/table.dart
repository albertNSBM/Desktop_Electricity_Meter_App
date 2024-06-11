import 'dart:convert';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart'; // Import foundation for kIsWeb
import 'dart:html' as html;
import 'package:admin_reg/configs/api.dart';

Future<void> requestPermissions() async {
  if (!kIsWeb) {
    await Permission.storage.request();
  }
}

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<Map<String, dynamic>> dispenses = [];
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getDispenses();
  }

  Future<void> getDispenses() async {
    String? authToken = await storage.read(key: 'auth_token');
    final url = Uri.parse('${BackendUrl}/api/dispenses/');
    final response = await http.get(
      url,
      headers: {"Authorization": "Token $authToken"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        dispenses = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  String formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      return formatter.format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  Future<void> _generateExcel() async {
    await requestPermissions();

    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];

    // Adding column headers
    sheet.getRangeByName('A1').setText('Date');
    sheet.getRangeByName('B1').setText('Name');
    sheet.getRangeByName('C1').setText('Service');
    sheet.getRangeByName('D1').setText('Assigned cashpower');

    // Adding data from dispenses
    for (int i = 0; i < dispenses.length; i++) {
      final dispense = dispenses[i];
      sheet.getRangeByName('A${i + 2}').setText(formatDate(dispense['done_at']));
      sheet.getRangeByName('B${i + 2}').setText(dispense['request']['client']);
      sheet.getRangeByName('C${i + 2}').setText(dispense['request']['service']);
      sheet.getRangeByName('D${i + 2}').setText(dispense['cash_power']);
    }

    try {
      // Save the workbook to bytes
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (!kIsWeb) {
        // Get the application documents directory
        final io.Directory directory = await getApplicationDocumentsDirectory();
        final String filePath = '${directory.path}/dispenses.xlsx';

        // Write the Excel file to the documents directory
        final io.File file = io.File(filePath);
        await file.writeAsBytes(bytes);

        // Show success message or handle further actions
        print('Excel file saved successfully at: $filePath');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Excel file saved at $filePath')),
        );
      } else {
        // Handle web-specific file saving
        final blob = html.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'dispenses.xlsx')
          ..click();
        html.Url.revokeObjectUrl(url);
        print('Excel file downloaded successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Excel file downloaded')),
        );
      }
    } catch (e) {
      print('Error generating Excel file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating Excel file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _generateExcel,
            child: Text('Download'),
          ),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(child: Text('Dates', textAlign: TextAlign.center)),
                  TableCell(child: Text('Names', textAlign: TextAlign.center)),
                  TableCell(child: Text('Service', textAlign: TextAlign.center)),
                  TableCell(child: Text('Assigned cashpower', textAlign: TextAlign.center)),
                ],
              ),
              ...dispenses.map((dispense) {
                return TableRow(
                  children: [
                    Text(formatDate(dispense['done_at']) ?? ''),
                    Text(dispense['request']['client'] ?? ''),
                    Text(dispense['request']['service'] ?? ''),
                    Text(dispense['cash_power'] ?? ''),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Scaffold(body: MyTable())));
}
