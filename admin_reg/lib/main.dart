
import 'package:flutter/material.dart';
import 'package:admin_reg/pages/home.dart';
import 'package:admin_reg/pages/login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/home':(context)=>Home(),
      '/login':(context)=>Login(),

    },
  ));
}
