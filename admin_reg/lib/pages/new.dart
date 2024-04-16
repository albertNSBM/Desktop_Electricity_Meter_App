import 'package:flutter/material.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  final List _list = [
   'Record1',
   'Record2',
   'Record3',
   'Record4',
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
