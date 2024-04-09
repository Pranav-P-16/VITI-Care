
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viticare/helper/token.dart';

import '../helper/Student.dart';

class APIs {
  static FirebaseAuth auth= FirebaseAuth.instance;
  static late Student me;
  static FirebaseFirestore firestore= FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection('users')
        .doc(user.uid)
        .get()).exists;
  }
  static Future<void> createUser(int _currenValue,String _currenValue2) async {

    final chatUser=Student(Name: user.displayName.toString(),
        Registration: user.displayName!.substring(user.displayName!. lastIndexOf(' ') + 1),
        Block: _currenValue2, RoomNo: _currenValue.toString(), id: user.uid, isRaised: false);

    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }
  static Future<void> getSelfinfo() async {
    await firestore.collection('users')
        .doc(user.uid)
        .get()
        .then((user) async {
      if (user.exists){
        me=Student.fromJson(user.data()!);
      }});
  }
  static Future<void> raiseToken() async {
    await APIs.getSelfinfo().then((value) async {
      final time=DateTime.now().millisecondsSinceEpoch.toString();
      final Token token=Token(id:me.id, name: me.Name, roomNo: me.RoomNo, block: me.Block, otp: me.Block,datetime:time.toString()
      ,isdone: false);
      await firestore.collection('tokens').doc(me.id).collection('active').doc(time).set(token.toJson());
    });

  }
  static Future<void> updateTokenStatus(bool raised) async{
    firestore.collection('users').
    doc(user.uid).update({'isRaised' : raised, 'raised_time' : DateTime.now().millisecondsSinceEpoch.toString(),});
  }
  static Stream <QuerySnapshot<Map<String, dynamic>>> getTokenStatus() {
    return firestore.collection('tokens/'+user.uid+'/active/').orderBy('isdone',descending: false).limit(1).snapshots();
  }
}
