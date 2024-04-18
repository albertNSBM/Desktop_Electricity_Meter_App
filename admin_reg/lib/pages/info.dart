import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  void dropdowncallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        var _dropdownValue = selectedValue;
      });
    }
  }

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
                            Text('Names:....................'),
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
                    children: [
                      Column(
                        children: [
                          DropdownButton(
                            items: [
                              DropdownMenuItem(child: Text('Byemejwe')),
                              DropdownMenuItem(child: Text('Byanzwe'))
                            ],
                            value: _dropdownValue,
                            onChanged: dropdowncallback,
                          )
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
