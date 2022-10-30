

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails{
  String? phoneNo;
  String? uid;
  String? username;

  UserDetails({this.phoneNo,this.uid,this.username});

  factory UserDetails.fromDocument(DocumentSnapshot<Map<String,dynamic>> snapshot){
    var d = snapshot.data()!;
    return UserDetails(
      phoneNo: d['phoneNo'],
      uid: d['uid'],
      username: d['username']
    );
  }

}