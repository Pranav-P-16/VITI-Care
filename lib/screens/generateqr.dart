import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:viticare/helper/Student.dart';
import 'package:viticare/helper/token.dart';

import 'package:google_fonts/google_fonts.dart';

import '../api/apis.dart';

class GenerateQR extends StatefulWidget {
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {

  @override
  Widget build(BuildContext context) {
    //APIs.raiseToken();
    //var user=APIs.user;
    //final Token token=Token(id: user.uid, name: user.displayName.toString(), roomNo: "824", block: "M", otp: "2345");
    //APIs.updateTokenStatus(true);

    return Scaffold(
      //Appbar having title
      appBar: AppBar(
        title: Text("Scan this QR Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Applied for room cleaning...",style: GoogleFonts.oswald(fontSize: 20),),
            SizedBox(height: 50,),
            //Center(child: QrImageView(data: token.toJson().toString())),
            SizedBox(height: 50),
            Text("Show this QR Code once cleaning is over...",style: TextStyle(color: Colors.red,fontSize: 15),),
          ],
        ),
      ),
    );
  }
}