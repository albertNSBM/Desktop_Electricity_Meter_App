import 'package:flutter/material.dart';

class Repair extends StatefulWidget {
  const Repair({super.key});

  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  final List _list = [
    'Record1',
    'Record2',
    'Record3',
    'Record4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Row(children: [
                    Text(_list[index]),
                    Icon(
                      Icons.pending,
                      size: 70,
                    )
                  ]),
                ],
              ),
            );
          }),
    );
  }
}
