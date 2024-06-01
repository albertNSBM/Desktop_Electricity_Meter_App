import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:admin_reg/pages/info.dart';

class Desplacement extends StatefulWidget {
  const Desplacement({super.key});

  @override
  State<Desplacement> createState() => _DisplaceState();
}

class _DisplaceState extends State<Desplacement> {

  List<Map<String, dynamic>> requests = [];

  @override
  void initState() {
    getNewRequests();
  }

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> getNewRequests() async {
    String? user = await storage.read(key: 'user_id');
    String? authToken = await storage.read(key: 'auth_token');
    final url = Uri.parse('http://127.0.0.1:8000/api/displace-requests/');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Token $authToken",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        setState(() {
          requests = List<Map<String, dynamic>>.from(data);
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Client: ${request['client']['first_name']} ${request['client']['last_name']}'),

                            Text('Service: ${request['requested_service']}'),

                            Text('Requested on: ${formatDate(request['requested_on'])}'),
                          ],
                        ),

                        SizedBox(width: 20,),

                        IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Info(request: request['id'])),
                            ),
                            icon: Icon(
                              Icons.pending,
                              size: 30,
                            )),

                      ]),
                    ],
                  )
                ],
              ),

            );
          }),
    );
  }
}
