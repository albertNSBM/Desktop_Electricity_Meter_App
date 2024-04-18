import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
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
                height: 400,
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
                          if (_key.currentState!.validate()) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
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
