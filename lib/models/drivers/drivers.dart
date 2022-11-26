

import 'package:cloud_firestore/cloud_firestore.dart';

class DriverDetails{

  String? id;
  String? phoneNo;
  String? name;

  DriverDetails({this.id,this.phoneNo,this.name});


  factory DriverDetails.fromDocument(DocumentSnapshot<Map<String,dynamic>> snapshot){
    var d = snapshot.data();
    return DriverDetails(
      id: d!['id'],
      phoneNo: d['phoneNo'],
      name: d['name']
    );
  }

}