import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String _dropdownValue = 'Byemejwe';
  var _items = [
    'Byemejwe',
    'Byanzwe',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/Reg.png')),
          ],
        ),
        Column(
          children: [
            Container(
              height: 6,
              width: 800,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              height: 500,
              width: 800,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 10,
                      ),
                      Text('Client-Info'),
                      SizedBox(width: 230),
                      TextButton(onPressed: () {}, child: Text('Logout'))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amazina:....................'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Akarere:...................'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Umurenge:..................'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Akagari:...................'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Umudugudu:................'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('No Yinzu:...................'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Telephone:0786 455 654'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Photocopi Y'indangamuntu",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white70,
                                  minimumSize: Size(300, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.download,
                                      size: 25,
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Icyangombwa Cy'ubutaka",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white70,
                                  minimumSize: Size(300, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.download,
                                      size: 25,
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 50,
                            ),
                            Row(children: [
                              SizedBox(
                                width: 80,
                              ),
                              Text('Not Paid!'),
                            ])
                          ],
                        ),
                      )
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                         
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffEBEDFE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton(
                              items: _items.map(
                                (String item) {
                                  return DropdownMenuItem(
                                      value: item, child: Text(item));
                                },
                              ).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _dropdownValue = newValue!;
                                });
                              },
                              value: _dropdownValue,
                              borderRadius: BorderRadius.circular(10),
                              style: TextStyle(color: Colors.black),
                              icon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                          SizedBox(height: 10,),
                            ElevatedButton(
                              onPressed: () {
                            
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Color(0xffEBEDFE),
                                minimumSize: Size(200, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
