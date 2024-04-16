import 'package:flutter/material.dart';

class Desplacement extends StatefulWidget {
  const Desplacement({super.key});

  @override
  State<Desplacement> createState() => _DesplacementState();
}

class _DesplacementState extends State<Desplacement> {
  final List _list = [
   'Record1',
   'Record2',
   'Record3',
   'Record4',
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
          }) ,
    );
  }
}