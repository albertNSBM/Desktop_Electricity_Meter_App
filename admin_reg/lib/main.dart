import 'package:admin_reg/pages/creatadmin.dart';
import 'package:admin_reg/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:admin_reg/pages/home.dart';
import 'package:admin_reg/pages/login.dart';
import 'package:admin_reg/pages/paid.dart';
import 'package:admin_reg/pages/repair.dart';
import 'package:admin_reg/pages/creatadmin.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/create',
    routes: {
      '/home': (context) => Home(),
      '/login': (context) => Login(),
      '/info': (context) => Info(),
      '/paid': (context) => Paid(),
      '/repair': (context) => Repair(),
      '/create': (context) => Create_Admin()
    },
  ));
}
