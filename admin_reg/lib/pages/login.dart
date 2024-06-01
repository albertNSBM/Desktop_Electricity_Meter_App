import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login(Map<String, dynamic> jsonData) async {
    Map<String, dynamic> jsonData = {
      'email': email.text,
      'password': password.text,
    };

    final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/login/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonData),
    );

    if(response.statusCode == 401) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: Text("Unauthenticated"),
              content: Text("Invalid cre")
          );
        },
      );
    }
    else {
      if (response.body != null) {

        try {
          Map<String, dynamic> responseData = json.decode(response.body);

          print(responseData);

          final token = responseData['token'];

          final userId = responseData['user']['id'].toString();

          final storage = new FlutterSecureStorage();

          await storage.write(key: 'auth_token', value: token);

          await storage.write(key: 'user_id', value: userId);

          Navigator.pushReplacementNamed(context, '/home');
        }
        catch (e) {
          print("Error: $e");
        }
      }

    }
  }

  bool isEmailCorrect=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/Reg.png'),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                height: 5,
                width: 600,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                width: 600,
                height: 450,
                decoration: BoxDecoration(color: Colors.grey),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Admin Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 80,
                              width: 300,
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: 10,
                                    ),
                                    labelText: 'Email ',
                                    labelStyle: TextStyle(fontSize: 15.0)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*";
                                  }
                                },
                              )),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                              height: 80,
                              width: 300,
                              child: TextFormField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                    
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size: 10,
                                    ),
                                    labelText: 'Password ',
                                    labelStyle: TextStyle(fontSize: 15.0)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*";
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          login({'key': 'value'});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(200, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        )),
                        SizedBox(height: 20,),
                        TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/create');
                      },
                      child: Text(
                        'Create Admin?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
