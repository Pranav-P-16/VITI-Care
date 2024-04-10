import 'dart:developer';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:viticare/helpers/dialogues.dart';
import 'package:viticare/screens/generateqr.dart';

import '../api/apis.dart';
import '../helper/token.dart';
import '../main.dart';

class TimeScheduler extends StatefulWidget {
  const TimeScheduler({super.key});

  @override
  State<TimeScheduler> createState() => _TimeSchedulerState();
}

class _TimeSchedulerState extends State<TimeScheduler> {
  TimeOfDay _currentime = TimeOfDay.now();
  late DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Choose your preferred time",style: GoogleFonts.oswald(fontSize: 30),),
          SizedBox(height: 30,),
          Center(
            child: TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.black54
              ),
              highlightedTextStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.black
              ),
              spacing: 50,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  _dateTime = time;
                });
              },
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            if (_dateTime.hour<7 || _dateTime.hour>18) {
              Dialogues.smallSnack(context, "Working hours between 7AM-6PM", Colors.orange);
            } else {
              _confirmBox_applyCLeaning(_dateTime.hour.toString(), _dateTime.minute.toString());
            }
          },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: Size(mq.width*.4, mq.height*.06),
                backgroundColor: Colors.lightBlueAccent.shade200,
              ),
              child: Text("Apply for room cleaning",style: GoogleFonts.oswald(fontSize: 20,color: Colors.black),)),
        ],
      )
      // body:SizedBox(
      //   child: TimePickerDialog(
      //     initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      //     onEntryModeChanged:  (p0) {
      //       var time=p0;
      //       log('ddsds');
      //     },
      //     // onTimeChange: (TimeOfDay time) {
      //     //   print(
      //     //       "What we get the value of the time is now $time");
      //     // },
      //   ),
      // ),
    );
  }
  void _confirmBox_applyCLeaning(String hr, String mn){
    showDialog(context: context, builder: (_)=> AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      title: Row(children: [
        Icon(Icons.cleaning_services,color: Colors.deepOrange,size: 28,),
        Text(' Apply')
      ],),
      content:
      Text("You are applying room cleaning for "+hr+":"+mn,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.left),
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        },child: Text('Cancel',style: TextStyle(color: Colors.blue,fontSize: 16),),),
        MaterialButton(onPressed: () async {
          APIs.getSelfinfo();
          if (APIs.me.isRaised==false) {
            Dialogues.showSnackBar(context, "Room Cleaning have been applied", Colors.green);
            Navigator.pop(context);
            Navigator.pop(context);
          await APIs.raiseToken();
          await APIs.updateTokenStatus(true);
        } else {
            Navigator.pop(context);
            Navigator.pop(context);
            Dialogues.showSnackBar(context, "You've already applied once", Colors.red);
          }
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>GenerateQR()));
        },child: Text('Apply',style: TextStyle(color: Colors.red,fontSize: 16),),),
      ],
    ));
  }
}
