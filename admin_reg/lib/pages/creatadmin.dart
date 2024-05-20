import 'package:flutter/material.dart';

class Create_Admin extends StatefulWidget {
  const Create_Admin({super.key});

  @override
  State<Create_Admin> createState() => _Create_AdminState();
}

class _Create_AdminState extends State<Create_Admin> {
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
                height: 700,
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
                          'Create Admin',
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
                                      Icons.person,
                                      size: 10,
                                    ),
                                    labelText: 'Full Names',
                                    labelStyle: TextStyle(fontSize: 15.0)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*";
                                  }
                                },
                              )),
                          SizedBox(
                            height: 20,
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
                            height: 20,
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
                          SizedBox(
                            height: 20,
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
                                    labelText: 'Confirm Password',
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
                           Navigator.pushReplacementNamed(context, '/login');
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
                          'Create',
                          style: TextStyle(color: Colors.black),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Login?',
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
