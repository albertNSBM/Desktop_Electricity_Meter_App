import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
          title: Row(children:[Text('Admin',style: TextStyle(color: Colors.redAccent[100],fontWeight: FontWeight.bold),),
          SizedBox(width:850,),TextButton(onPressed: (){}, child: Text('Logout'))]),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Content(),
            Expanded(
                child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.black,
                ),
                Container(color: Colors.green),
                Container(),
                Container(
                  color: Colors.blue,
                ),
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
          onDestinationSelected:(newIndex) {
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
          ],
          labelType: labelType,
        ),
      ]),
    );
  }
}