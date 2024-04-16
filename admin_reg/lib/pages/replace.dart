import 'package:flutter/material.dart';

class Replace extends StatefulWidget {
  const Replace({super.key});

  @override
  State<Replace> createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  final List _list = [
   'Record1',
   'Record2',
   'Record3',
   'Record4',
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body:ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Row(children: [
                    Text(_list[index]),
                    Icon(Icons.pending,size: 70,)
                  ]),
                ],
              ),
            );
          }),
    );
  }
}