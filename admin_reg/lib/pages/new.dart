import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:admin_reg/pages/info.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart'; // Import foundation for kIsWeb
import 'package:admin_reg/configs/api.dart';
import 'dart:html' as html;

Future<void> requestPermissions() async {
  if (!kIsWeb) {
    await Permission.storage.request();
  }
}

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  List<Map<String, dynamic>> requests = [];

  @override
  void initState() {
    getNewRequests();
    super.initState();
  }

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> getNewRequests() async {
    String? user = await storage.read(key: 'user_id');
    String? authToken = await storage.read(key: 'auth_token');
    final url = Uri.parse('${BackendUrl}/api/new-requests/');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Token $authToken",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        requests = List<Map<String, dynamic>>.from(data);
      });
    } else {
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

  Future<void> _downloadReport() async {
    await requestPermissions();

    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];

    // Adding column headers
    sheet.getRangeByName('A1').setText('Date');
    sheet.getRangeByName('B1').setText('Client');
    sheet.getRangeByName('C1').setText('Service');

    // Adding data from dispenses
    for (int i = 0; i < requests.length; i++) {
      final request = requests[i];
      sheet.getRangeByName('A${i + 2}').setText(formatDate(request['requested_on']));
      sheet.getRangeByName('A${i + 2}').setText(formatDate(request['requested_on']));
      sheet.getRangeByName('B${i + 2}').setText('${request['client']['first_name']} ${request['client']['last_name']}');
      sheet.getRangeByName('C${i + 2}').setText(request['requested_service']);
    }

    try {
      // Save the workbook to bytes
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (!kIsWeb) {
        // Mobile platform file saving
        // Make sure to handle file operations correctly for mobile platforms
      } else {
        // Web-specific file saving
        final blob = html.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'new_meter_requests.xlsx')
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
    return Scaffold(
      appBar: AppBar(
        title: Text('New meter requests'),
        actions: [
          TextButton(
            child: Text('Download report'),
            onPressed: _downloadReport,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Client: ${request['client']['first_name']} ${request['client']['last_name']}'),
                        Text('Service: ${request['requested_service']}'),
                        Text('Requested on: ${formatDate(request['requested_on'])}'),
                      ],
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Info(request: request['id'])),
                      ),
                      icon: Icon(
                        Icons.pending,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
