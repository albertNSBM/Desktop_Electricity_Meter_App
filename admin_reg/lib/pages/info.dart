import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart'; // Import foundation for kIsWeb
import 'package:admin_reg/configs/api.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_downloader_web/image_downloader_web.dart';

Future<void> requestPermissions() async {
  if (!kIsWeb) {
    await Permission.storage.request();
  }
}

Future<void> _downloadImage(String url) async {
  await WebImageDownloader.downloadImageFromWeb(url);
}

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      print('Storage permission granted');
    } else {
      print('Storage permission denied');
    }
  } else {
    print('Storage permission already granted');
  }
}

class Info extends StatefulWidget {
  final int request;
  const Info({Key? key, required this.request}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String _dropdownValue = 'Accept';
  final List<String> _items = ['Accept', 'Reject'];
  Map<String, dynamic> requestInfo = {};
  List<Map<String, dynamic>> requestFiles = [];
  bool isLoading = true;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final TextEditingController note = TextEditingController();

  @override
  void initState() {
    requestStoragePermission();
    _dropdownValue = _items.first;
    getRequestInfo();
    getRequestFiles();
  }

  Future<void> getRequestInfo() async {
    try {
      String? authToken = await storage.read(key: 'auth_token');
      final url = Uri.parse('${BackendUrl}/api/request/${widget.request}');
      final response = await http.get(
        url,
        headers: {"Authorization": "Token $authToken"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            requestInfo = Map<String, dynamic>.from(data);
            isLoading = false;
            note.text = requestInfo['note'] ?? '';
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> getRequestFiles() async {
    try {
      String? authToken = await storage.read(key: 'auth_token');
      final url = Uri.parse('http://127.0.0.1:8000/api/req-uploads/${widget.request}');
      final response = await http.get(
        url,
        headers: {"Authorization": "Token $authToken"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          setState(() {
            requestFiles = List<Map<String, dynamic>>.from(data);
          });
        } else {
          print('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading files: $e');
    }
  }

  Future<void> updateRequest() async {
    try {
      String? authToken = await storage.read(key: 'auth_token');
      Map<String, dynamic> jsonData = {"decision": _dropdownValue, "note": note.text};
      final url = Uri.parse('${BackendUrl}/api/update-request/${widget.request}');
      final response = await http.put(
        url,
        headers: {
          "Authorization": "Token $authToken",
          "Content-Type": "application/json"
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        setState(() {
          requestInfo['decision'] = _dropdownValue;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Updated successfully"),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to update"),
            );
          },
        );
      }
    } catch (e) {
      print('Error updating request: $e');
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    try {
      // Send HTTP GET request to download the image
      http.Response response = await http.get(Uri.parse(imageUrl));

      // Check if the request was successful (status code 200)
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Convert the response body to Uint8List (bytes)
        Uint8List bytes = response.bodyBytes;
        print(bytes);

        // Create an object URL from the bytes
        String url = html.Url.createObjectUrlFromBlob(html.Blob([bytes]));

        // Create an anchor element to trigger the download
        html.AnchorElement anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'image.jpg')
          ..click();

        // Revoke the object URL to free up resources
        html.Url.revokeObjectUrl(url);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }


  Future<void> requestToPay() async {
    try {
      String? authToken = await storage.read(key: 'auth_token');
      Map<String, dynamic> jsonData = {"decision": "Requested to pay", "note": note.text};
      final url = Uri.parse('${BackendUrl}/api/update-request/${widget.request}');
      final response = await http.put(
        url,
        headers: {"Authorization": "Token $authToken",
          "Content-Type": "application/json"
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        setState(() {
          requestInfo['decision'] = "Requested to pay";
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Updated successfully"),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to update"),
            );
          },
        );
      }
    } catch (e) {
      print('Error requesting to pay: $e');
    }
  }

  Future<void> openFile(String url) async {
    await requestPermissions();

    try {
      final response = await http.get(Uri.parse(url));
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/${url.split('/').last}');
      await file.writeAsBytes(response.bodyBytes);

      OpenFile.open(file.path);
    } catch (e) {
      print('Error opening file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(child: Image.asset('assets/Reg.png')),
          SizedBox(height: 20),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request Information'),
                SizedBox(height: 10),
                buildClientInfo(),
                SizedBox(height: 30),
                buildRequestFiles(),
                SizedBox(height: 30),
                buildDecisionSection(),
                SizedBox(height: 30),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back),
                        Text('Back'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildClientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Names: ${requestInfo['client']?['first_name'] ?? 'Loading...'} ${requestInfo['client']?['last_name'] ?? ''}'),
        SizedBox(height: 10),
        Text('District: ${requestInfo['district'] ?? 'Loading...'}'),
        SizedBox(height: 10),
        Text('Sector: ${requestInfo['sector'] ?? 'Loading...'}'),
        SizedBox(height: 10),
        Text('Cell: ${requestInfo['cell'] ?? 'Loading...'}'),
        SizedBox(height: 10),
        Text('Village: ${requestInfo['village'] ?? 'Loading...'}'),
        SizedBox(height: 10),
        Text('House No: ${requestInfo['house_no'] ?? ''}'),
        SizedBox(height: 10),
        Text('ID: ${requestInfo['client']?['id_card_number'] ?? ''}'),
        SizedBox(height: 10),
        Text('Telephone: ${requestInfo['client']?['phone_number'] ?? ''}'),
      ],
    );
  }

  Column buildRequestFiles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Documents'),
        requestFiles.isEmpty
            ? Text('Files: No files')
            : ListView.builder(
          itemCount: requestFiles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final file = requestFiles[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(file['type'] ?? '')),
                    SizedBox(width: 10),
                    Image.network("http://127.0.0.1:8000/media/files/33.jpg",height: 100,),
                    ElevatedButton(
                      onPressed: () async {
                        _downloadImage("http://127.0.0.1:8000/media/files/33.jpg");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        minimumSize: Size(30, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      child: Text('Open'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Row buildDecisionSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status: ${requestInfo['decision'] ?? ''}'),
              SizedBox(height: 10),
              Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Color(0xffEBEDFE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: _items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownValue = newValue!;
                    });
                  },
                  value: _dropdownValue,
                  borderRadius: BorderRadius.circular(10),
                  style: TextStyle(color: Colors.black),
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  requestToPay();
                },
                child: Text("Request to pay"),
              ),
              SizedBox(height: 10),
              Text('Reason:'),
              SizedBox(height: 10),
              TextFormField(
                controller: note,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter reason',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: updateRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffEBEDFE),
                  minimumSize: Size(200, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                child: Text('Save', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
