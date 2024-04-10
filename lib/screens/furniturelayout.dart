import 'package:flutter/material.dart';

import '../helpers/dialogues.dart';
import '../main.dart';

class FurnitureDesc extends StatefulWidget {
  const FurnitureDesc({super.key});

  @override
  State<FurnitureDesc> createState() => _FurnitureDescState();
}

class _FurnitureDescState extends State<FurnitureDesc> {
  var desc=' ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter a short description: ",style: TextStyle(
              fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 20,),
            TextFormField(
                textCapitalization: TextCapitalization.words,
                maxLength: 250,
                maxLines: 10,
                onSaved: (val)=> desc=val ?? '',
                validator: (val) => val!=null && val.isNotEmpty?null : 'Required Field',
                decoration: InputDecoration(prefixIcon: Icon(Icons.pending_actions_sharp,color: Colors.blue,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    hintText: 'Problem Description',
                    hintMaxLines: 1,
                    label: Text('Problem Description'))),
            SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
          Dialogues.showSnackBar(context, "Complaint registered successfully", Colors.green);
        },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: Size(mq.width*.4, mq.height*.06),
              backgroundColor: Colors.lightBlueAccent.shade200,
            ),
            child: Text("Submit Report",style: TextStyle(fontSize: 20,color: Colors.black),)),
          ],
        ),
      ),
    );
  }
}
