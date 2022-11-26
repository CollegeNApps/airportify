

import 'package:cloud_firestore/cloud_firestore.dart';

class Access{
  List? drivers;
  Access({this.drivers});

  factory Access.fromDocument(DocumentSnapshot<Map<String,dynamic>> snapshot){
    var d = snapshot.data();
    return Access(
      drivers: d!['drivers']
    );
  }
}