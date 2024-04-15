
import 'package:flutter/material.dart';
import 'package:admin_reg/pages/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home':(context)=>Home(),

    },
  ));
}
