import 'package:flutter/material.dart';
class Served extends StatefulWidget {
  const Served({super.key});

  @override
  State<Served> createState() => _ServedState();
}

class _ServedState extends State<Served> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center ( child:Text('List of All served clients'),)
      ),
      body: ListView(),
    );
  }
}