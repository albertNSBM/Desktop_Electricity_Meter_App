import 'dart:async';

import 'package:admin_reg/pages/desplacement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:admin_reg/pages/new.dart';
import 'package:admin_reg/pages/replace.dart';
import 'package:admin_reg/pages/repair.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  int selectedIndex = 0;


  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(children: [
            Text(
              'Admin',
              style: TextStyle(
                  color: Colors.redAccent[100], fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 850,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Logout'))
          ]),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Content(),
            Expanded(
                child: PageView(
                physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                New(),
                Replace(),
                Repair(),
                Desplacement(),
              ],
            ))
          ],
        ));
  }

  Widget Content() {
    return Container(
      color: Colors.white,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        NavigationRail(
          backgroundColor: Colors.grey[300],
          selectedIconTheme: IconThemeData(color: Colors.redAccent[100]),
          onDestinationSelected: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
              pageController.animateToPage(newIndex,
                  duration: Duration(microseconds: 25),
                  curve: Curves.easeInOut);
            });
          },
          selectedIndex: selectedIndex,
          destinations: [
            NavigationRailDestination(
                icon: Icon(
                  Icons.electric_bolt,
                  size: 30,
                ),
                label: Text(
                  "New",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            NavigationRailDestination(
                icon: Icon(
                  Icons.find_replace,
                  size: 30,
                ),
                label: Text(
                  "Replace",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            NavigationRailDestination(
                icon: Icon(
                  Icons.home_repair_service,
                  size: 30,
                ),
                label: Text(
                  "Repair",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            NavigationRailDestination(
                icon: Icon(
                  Icons.next_plan,
                  size: 30,
                ),
                label: Text(
                  "Displace",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                 NavigationRailDestination(
                icon: Icon(
                  Icons.report,
                  size: 30,
                ),
                label: Text(
                  "Report(s)",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
          labelType: labelType,
        ),
      ]),
    );
  }
}
