import 'package:admin_reg/pages/creatadmin.dart';
import 'package:admin_reg/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:admin_reg/pages/home.dart';
import 'package:admin_reg/pages/login.dart';
import 'package:admin_reg/pages/paid.dart';
import 'package:admin_reg/pages/repair.dart';
import 'package:admin_reg/pages/creatadmin.dart';
import 'package:admin_reg/pages/served.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //
  // WidgetsFlutterBinding.ensureInitialized();
  // await initPathProvider();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/paid': (context) => Paid(),
        '/repair': (context) => Repair(),
        '/create': (context) => Create_Admin(),
        '/served': (context) => Served()
      },
    );
  }
}


// Future<void> initPathProvider() async {
//   await getApplicationSupportDirectory();
// }