import 'dart:developer';
import 'dart:ui';

import 'package:airportify/models/drivers/drivers.dart';
import 'package:airportify/models/user/bookings.dart';
import 'package:airportify/models/user/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/drivers/access.dart';
import '../models/flight/flight_info.dart';
import 'auth_controller.dart';

class FirebaseController extends GetxController {
  final _flights = [FlightInfo()].obs;
  final _bookings = [BookingInfo()].obs;
  List<FlightInfo> get flights => _flights.value;
  List<BookingInfo> get bookings => _bookings.value;

  List<dynamic> userPhoneNos = [];

  RxInt journeyType = 0.obs;
  RxInt serviceType = 0.obs;

  final flightStatusCodeColors = const [
    Color(0xff7ad95b),
    Color(0xffffbb3e),
    Color(0xff7f7f7f),
    Color(0xffec4646)
  ];

  @override
  void onInit() {
    super.onInit();
    _flights.bindStream(connectFlightStream());
    _bookings.bindStream(connectBookingStream());
  }

  deleteDocument(String id) {
    FirebaseFirestore.instance.collection('bookings').doc(id).delete();
  }

  Stream<List<FlightInfo>> connectFlightStream() {
    var result = FirebaseFirestore.instance
        .collection('flights')
        .snapshots()
        .map((query) {
      var docs = query.docs.map((e) => FlightInfo.fromDocument(e)).toList();
      return docs;
    });
    return result;
  }

  Stream<List<BookingInfo>> connectBookingStream() {
    var result = FirebaseFirestore.instance
        .collection('bookings')
        .snapshots()
        .map((query) {
      var docs = query.docs.map((e) => BookingInfo.fromDocument(e)).toList();
      return docs;
    });
    return result;
  }

  static Future<UserDetails> fetchUserInfo(User user) async {
    var userResult = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((query) {
      var docs = query.docs.map((e) => UserDetails.fromDocument(e)).toList();
      return docs[0];
    });
    return userResult;
  }

  void getPhoneNumbers() async {
    final db = await Db.create(
        'mongodb+srv://college_apps:collegeappsmongodb77@usurper.lhfsizd.mongodb.net/CollegeApps?retryWrites=true&w=majority');
    await db.open();
    inspect(db);
    final phoneNos = await db.collection('Airportify').find().toList();
    print("Phone numbers via Mongo db :${phoneNos[0]['users']}");

    userPhoneNos = phoneNos[0]['users'];
  }

  Future<bool> checkDriverAccess(String phoneNumber) async {
    var result = await FirebaseFirestore.instance
        .collection('access')
        .get()
        .then((query) {
      var res = query.docs.map((e) => Access.fromDocument(e)).toList();
      var access = res[0].drivers!.contains(phoneNumber);
      return access;
    });
    print("Driver Access :$result");
    return result;
  }

  static Future<DriverDetails> fetchDriverInfo(User user) async {
    var userResult = await FirebaseFirestore.instance
        .collection('drivers')
        .where('id', isEqualTo: user.uid)
        .get()
        .then((query) {
      var docs = query.docs.map((e) => DriverDetails.fromDocument(e)).toList();
      return docs[0];
    });
    return userResult;
  }

  createUserAccount(String phoneNo, String uid) {
    print("Entered Creating account function");
    FirebaseFirestore.instance.collection('users').doc().set({
      'username': AuthController.username,
      'phoneNo': phoneNo.substring(3),
      'uid': uid
    });
    print("Created account");
  }

  createDriverAccount(String phoneNo, String uid) {
    print("Entered Creating Driver account function");
    FirebaseFirestore.instance.collection('drivers').doc().set({
      'phoneNo': phoneNo.substring(3),
      'id': uid,
      'name': AuthController.username
    });
  }

  Future<void> setSharedPreference(bool existence) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('driver', existence);
  }
}
