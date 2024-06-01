import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Info extends StatefulWidget {
  final int request;
  const Info({super.key, required this.request});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String _dropdownValue = 'Accept';
  final List<String> _items = ['Accept', 'Reject'];

  Map<String, dynamic> requestInfo = {};
  Map<String, dynamic> requestFiles = {};

  bool isLoading = true;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  TextEditingController note = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRequestInfo();
    _dropdownValue = _items.first;
    getRequestFiles();
  }

  Future<void> getRequestInfo() async {
    String? authToken = await storage.read(key: 'auth_token');
    final url = Uri.parse('http://127.0.0.1:8000/api/request/${widget.request}');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Token $authToken",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          requestInfo = Map<String, dynamic>.from(data);
          isLoading = false;
          note.text = requestInfo['note'] ?? '';  // Initialize reasonController
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getRequestFiles() async {
    String? authToken = await storage.read(key: 'auth_token');
    final url = Uri.parse('http://127.0.0.1:8000/api/req-uploads/${widget.request}');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Token $authToken",
      },
    );

    if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('Decoded Data: $data');
    if (mounted) {
      setState(() {
        requestFiles = Map<String, dynamic>.from(data);
        print('Updated Request Files: $requestFiles');
      });
    }


    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }

  Future<void> updateRequest() async {
    String? authToken = await storage.read(key: 'auth_token');

    Map<String, dynamic> jsonData = {
      "decision": _dropdownValue,
      "note": note.text,
    };

    final url = Uri.parse('http://127.0.0.1:8000/api/update-request/${widget.request}');
    final response = await http.put(
      url,
      headers: {
        "Authorization": "Token $authToken",
      },
      body: jsonData,
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
      throw Exception('Failed');
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
          Center(
            child: Image.asset('assets/Reg.png'),
          ),
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
                Row(
                  children: [
                    Text(
                      'Client-Info',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
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
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        requestFiles.isEmpty
                        ? Text('Files: No files')
                        : ListView.builder(
                          itemCount: requestFiles.length, // Corrected the itemCount
                          itemBuilder: (context, index) {
                            final file = requestFiles.values.elementAt(index); // Corrected accessing the file
                            return Column(
                              children: [
                                Text(
                                  file['type'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(file['file']),
                                    SizedBox(width: 30),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your logic for handling file download here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white70,
                                        minimumSize: Size(30, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.download, size: 25),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          },
                        )


                      ],
                    ),
                    Spacer(),
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
                            child: DropdownButton(
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
                          Text('Reason:'),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: note,  // Use the controller here
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter reason',
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              updateRequest();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffEBEDFE),
                              minimumSize: Size(200, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(2)),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
}
