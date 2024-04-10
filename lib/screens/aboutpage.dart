import 'package:flutter/material.dart';
import 'package:viticare/api/apis.dart';

import '../main.dart';

class ABoutPage extends StatefulWidget {
  const ABoutPage({super.key});

  @override
  State<ABoutPage> createState() => _ABoutPageState();
}

class _ABoutPageState extends State<ABoutPage> {
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: mq.height*.05,),
              Text("Profile",style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mq.height*.07,),
            Text("Name",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey),),
            Text(APIs.me.Name,style: TextStyle(fontSize: 24,color: Colors.blue),),
            SizedBox(height: 20,),
            Text("Reg No.",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey),),
            Text(APIs.me.Registration,style: TextStyle(fontSize: 24,color: Colors.blue),),
            SizedBox(height: 20,),
            Text("Block",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey),),
            Text(APIs.me.Block,style: TextStyle(fontSize: 24,color: Colors.blue),),
            SizedBox(height: 20,),
            Text("Room No.",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey),),
            Text(APIs.me.RoomNo,style: TextStyle(fontSize: 24,color: Colors.blue),)
          ],
        ),
      ),
    );
  }
}
