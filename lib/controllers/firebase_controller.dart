

import 'dart:ui';

import 'package:airportify/models/flight_info.dart';
import 'package:airportify/models/user/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController{


  final _flights = [FlightInfo()].obs;
  List<FlightInfo> get flights => _flights.value;


  RxInt journeyType = 0.obs;
  RxInt serviceType = 0.obs;

  final flightStatusCodeColors =  const[
    Color(0xff7ad95b),
    Color(0xffffbb3e),
    Color(0xff7f7f7f),
    Color(0xffec4646)
  ];

  @override
  void onInit() {
    super.onInit();
    _flights.bindStream(connectFlightStream());
  }

  Stream<List<FlightInfo>> connectFlightStream(){
    var result = FirebaseFirestore.instance.collection('flights').snapshots().map((query) {
      var docs = query.docs.map((e) => FlightInfo.fromDocument(e)).toList();
      return docs;
    });
    return result;
  }
  
  static Future<UserDetails> fetchUserInfo(User user)async{
    var userResult = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user.uid).get().then((query) {
      var docs = query.docs.map((e) => UserDetails.fromDocument(e)).toList();
      return docs[0];
    });
    return userResult;
  }

}