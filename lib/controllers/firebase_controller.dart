

import 'dart:developer';
import 'dart:ui';

import 'package:airportify/models/drivers/drivers.dart';
import 'package:airportify/models/user/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/drivers/access.dart';
import '../models/flight/flight_info.dart';

class FirebaseController extends GetxController{


  final _flights = [FlightInfo()].obs;
  List<FlightInfo> get flights => _flights.value;

  List<dynamic> userPhoneNos = [];

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

  void getPhoneNumbers()async{
    final db = await Db.create('mongodb+srv://college_apps:collegeappsmongodb77@usurper.lhfsizd.mongodb.net/CollegeApps?retryWrites=true&w=majority');
    await db.open();
    inspect(db);
    final phoneNos =await db.collection('Airportify').find().toList();
    print("Phone numbers via Mongo db :${phoneNos[0]['users']}");

    userPhoneNos = phoneNos[0]['users'];
  }

  Future<bool> checkDriverAccess(String phoneNumber)async{
    var result = await FirebaseFirestore.instance.collection('access').get().then((query) {
      var res = query.docs.map((e) => Access.fromDocument(e)).toList();
      var access = res[0].drivers!.contains(phoneNumber);
      return access;
    });
    print("Driver Access :$result");
    return result;
  }

  static Future<DriverDetails> fetchDriverInfo(User user)async{
    var userResult = await FirebaseFirestore.instance.collection('drivers').where('id',isEqualTo: user.uid).get().then((query) {
      var docs = query.docs.map((e) => DriverDetails.fromDocument(e)).toList();
      return docs[0];
    });
    return userResult;
  }




}