import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:viticare/helpers/dialogues.dart';
import 'package:viticare/screens/exp_homepage.dart';
import 'package:viticare/screens/homescreen.dart';

import '../api/apis.dart';
import '../main.dart';

class GetDetailsPage extends StatefulWidget {
  const GetDetailsPage({super.key});

  @override
  State<GetDetailsPage> createState() => _GetDetailsPageState();
}

class _GetDetailsPageState extends State<GetDetailsPage> {
  int _currenValue=0;
  String? _currenValue2;
  Map<String, String> dataset = {
    "A Block": 'A',
    "B Block": 'B',
    "C Block": 'C',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 204, 251, 1),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(150.0),
        child: FloatingActionButton(
          child: Icon(Icons.keyboard_double_arrow_right,color: Colors.black,),
          onPressed: () async {
            if(_currenValue2!=null&& _currenValue!=0) {
              Dialogues.showProgressBar(context);
              await APIs.createUser(_currenValue,_currenValue2!).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
              });
            } else {
              Dialogues.smallSnack(context, "Enter room and block details...", Colors.red);
            }
          },
        ),
      ),
      body: Stack(
        children: [Positioned(
          left: mq.width*.55,
          top: -mq.height*.05,
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                 Radius.circular(300),
              ),),
          )),
          Positioned(
              left: mq.width*.55,
              top: -mq.height*.05,
              child: Container(
                height: 290,
                width: 290,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(300),
                  ),),
              )),
        Positioned(
          left: -mq.width*.35,
          top: mq.height*.4,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(300),
              ),),
          )),
          Positioned(
              left: -mq.width*.35,
              top: mq.height*.4,
              child: Container(
                height: 195,
                width: 195,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(300),
                  ),),
              )),
          Positioned(
              left: mq.width*.55,
              bottom: -mq.height*.06,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(300),
                  ),),
              )),
          Positioned(
              left: mq.width*.55,
              bottom: -mq.height*.04,
              child: Container(
                height: 290,
                width: 290,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(300),
                  ),),
              )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Block    ",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w400
                ),),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currenValue2,
                    focusColor: Colors.white,
                    items: dataset.keys.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        _currenValue2 = v??' ';
                      });
                    },
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Room number    ",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w400
                ),),
                NumberPicker(
                  value: _currenValue,
                  minValue: 0,
                  maxValue: 1000,
                  onChanged: (value) => setState(() => _currenValue = value),
                ),
              ],
            ),

          ],
        )],
      ),
    );
  }
}
