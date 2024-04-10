import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:viticare/helpers/dialogues.dart';
import 'package:viticare/screens/aboutpage.dart';
import 'package:viticare/screens/furniturelayout.dart';
import 'package:viticare/screens/newloginpage.dart';
import 'package:viticare/screens/scanqr.dart';
import 'package:viticare/screens/statuspage.dart';
import 'package:viticare/screens/timescheduler.dart';
import '../api/apis.dart';
import 'package:snappy_list_view/snappy_list_view.dart';

import 'package:google_fonts/google_fonts.dart';

import '../main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    APIs.getSelfinfo();
    var greeting="Good Morning";
    DateTime now = DateTime.now();
    int nowHour = now.hour;
    if (nowHour>=12 && nowHour<=15) {
      greeting="Good Afternoon";
    } else if (nowHour>15 && nowHour<=19) {
      greeting = "Good Evening";
    }else if (nowHour>19) {
      greeting = "Good Night ;)";
    } else {
      greeting=greeting;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0,left: 15,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on,color: Colors.black,),
                        Text("VIT Vellore",style: GoogleFonts.oswald(fontSize: 15)),
                      ],
                    ),
                    Text(greeting+" "+APIs.user.displayName.toString().split(" ")[0],style: GoogleFonts.oswald(fontSize: 30),
                          ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=> ABoutPage()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height*.2),
                    child: Image.network(APIs.user.photoURL.toString(),height: 50,width: 50,)),
                ),
              ],
            ),
            SizedBox(height: mq.height*.05,),
            Center(child: Text("How can I Help you ;)",style: GoogleFonts.oswald(fontSize: 35),)),
            SizedBox(height: mq.height*.05,),
            Text(" Services",style: GoogleFonts.slabo13px(fontSize: 20),),
            SizedBox(height: 10,),
            Container(
              height: mq.height*.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>TimeScheduler()));
                      },
                      child: Stack(
                        children: [Container(
                          height: mq.height*.2,
                          width: mq.width*.6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height*.02),
                            child: Image.asset('assets/images/cleaning1.jpg',height: mq.height*.2,
                                width: mq.width*.5,),
                          ),
                        ),Text("\n\n\n\n"+"\t"*30+"Cleaning",style: GoogleFonts.oswald(fontSize: 20),),],
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>FurnitureDesc()));
                      },
                      child: Stack(
                        children: [Container(
                          height: mq.height*.2,
                          width: mq.width*.6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height*.02),
                            child: Image.asset('assets/images/cleaning2.jpg',height: mq.height*.2,
                              width: mq.width*.5,),
                          ),
                        ),Text("\n\n\n\n"+"\t"*2+"Repair",style: GoogleFonts.oswald(fontSize: 20),)],
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){
                        Dialogues.showToast(context, "Under Dev...");
                      },
                      child: Stack(
                        children: [Container(
                          height: mq.height*.2,
                          width: mq.width*.6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height*.02),
                            child: Image.asset('assets/images/cleaning3.jpg',height: mq.height*.2,
                              width: mq.width*.5,),
                          ),
                        ),Text("\n\n\n\n"+"\t"*2+"Painting",style: GoogleFonts.oswald(fontSize: 20),)],
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: (){
                        Dialogues.showToast(context, "Under Dev...");
                      },
                      child: Stack(
                        children: [Container(
                          height: mq.height*.2,
                          width: mq.width*.6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height*.02),
                            child: Image.asset('assets/images/cleaning4.jpg',height: mq.height*.2,
                              width: mq.width*.5,),
                          ),
                        ),Text("\n\n\n\n"+"\t"*30+"Electrical",style: GoogleFonts.oswald(fontSize: 20),)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>StatusPage()));
              },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(mq.width*.4, mq.height*.06),
                    backgroundColor: Colors.lightBlueAccent.shade200,
                  ),
                  child: Text("Check current service status",style: GoogleFonts.oswald(fontSize: 20,color: Colors.black),)),
            ),
            SizedBox(height: mq.height*.04,),
            Center(
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>StatusPage()));
              },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(mq.width*.4, mq.height*.06),
                    backgroundColor: Colors.lightBlueAccent.shade200,
                  ),
                  child: Text("Cleaning history",style: GoogleFonts.oswald(fontSize: 20,color: Colors.black),)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.login,color: Colors.black,),
        backgroundColor: Colors.red,
        onPressed: ()  {
          _confirmBox_logOut();},
    ));
  }
  void _confirmBox_logOut(){
    showDialog(context: context, builder: (_)=> AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      title: Row(children: [
        Icon(Icons.outbound,color: Colors.deepOrange,size: 28,),
        Text(' Logout')
      ],),
      content:
      Text("Are you sure?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.left),
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        },child: Text('Cancel',style: TextStyle(color: Colors.blue,fontSize: 16),),),
        MaterialButton(onPressed: () async {
          Dialogues.showProgressBar(context);
          await APIs.auth.signOut().then((value) async {
            await GoogleSignIn().signOut().then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> NewLoginPage()));
            });

          });
        },child: Text('Logout',style: TextStyle(color: Colors.red,fontSize: 16),),),
      ],
    ));
  }
}
