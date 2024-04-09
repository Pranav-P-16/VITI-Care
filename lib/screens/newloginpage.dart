import 'dart:io';
import 'getdetailspage.dart';
import 'homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/apis.dart';
import '../helpers/dialogues.dart';
import '../main.dart';

class NewLoginPage extends StatefulWidget {
  const NewLoginPage({super.key});

  @override
  State<NewLoginPage> createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleUser!.email.endsWith('vitstudent.ac.in')) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await APIs.auth.signInWithCredential(credential);
      } else {
        await GoogleSignIn().signOut();
        Dialogues.showSnackBar(context, "Use VIT Mail ID", Colors.orange);
      }
      // Create a new credential

    } catch(e) {
      // log('\n _signInWithGoogle: $e');
      Dialogues.showSnackBar(context,"Something went wrong!!!",Colors.red);
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 204, 251, 1),
      body: Padding(
        padding: const EdgeInsets.only(top:50.0),
        child: Stack(
          children: [Column(children: [SizedBox(height: 40,),Image.asset('assets/images/bg1.png')]),Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text("VITI-CARE",style: GoogleFonts.montserrat(fontSize: 36,color:Color.fromRGBO(18, 14, 121, 1),
              fontWeight: FontWeight.bold)),
              ),
            ],
          ),
            Padding(
              padding: EdgeInsets.only(top:mq.height*.7),

              child: Stack(
                children: [Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)//                 <--- border radius here
                    ),),
                ),
                  Padding(
                    padding: EdgeInsets.all( 60),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white,fixedSize: Size(300, 50),),
                        onPressed: (){
                          _handleGoogleBtnClick();
                        }, icon: Image.asset('assets/images/google.png',height: 30,),
                        label: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 25),
                              children: [
                                TextSpan(text: 'Log in with '),
                                TextSpan(
                                    text:'Google',
                                    style: TextStyle(fontWeight: FontWeight.w500)),

                              ]),
                        )),
                  ),],
              ),
            )],

        ),
      ),
    );
  }
  _handleGoogleBtnClick() {
    Dialogues.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user!=null) {
        if ((await APIs.userExists())){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>  HomeScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_)=> GetDetailsPage()));
        }
      }
    });
  }
}

