import 'dart:async';

import 'package:airportify/controllers/firebase_controller.dart';
import 'package:airportify/getx_ui/client_app/home_screen.dart';
import 'package:airportify/getx_ui/driver_app/driver_home.dart';
import 'package:airportify/models/user/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../getx_ui/phone_login_screen.dart';
import '../models/drivers/drivers.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  static UserDetails firebaseUser = UserDetails();
  static DriverDetails firebaseDriver = DriverDetails();

  RxBool driverExists = false.obs;
  static bool driverExists2 = false;

  late StreamSubscription subscription;
  final _hasInternet = false.obs;
  bool get hasInternet => _hasInternet.value;
  var signedInBool = true.obs;
  RxBool adminPass = false.obs;
  static String username = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      _hasInternet.value = true;
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());

    ever(_hasInternet, _handleInternetIssue);
    ever(_user, _initializeApp);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    subscription.cancel();
  }

  _initializeApp(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user == null) {
      print("Go to login page");
      Get.offAll(() => PhoneLoginScreen());
    } else {
      print("Go to home page");

      Future.delayed(const Duration(milliseconds: 500), () async {
        bool? screenRouteBool = prefs.getBool('driver');
        print("Driver Exists Status :$screenRouteBool");

        if(!screenRouteBool.isNull){
          if (screenRouteBool == false) {
            AuthController.firebaseUser = await FirebaseController.fetchUserInfo(user);
            Get.off(() => HomeScreen());
          } else {
            AuthController.firebaseDriver = await FirebaseController.fetchDriverInfo(user);
            Get.off(() => const DriverHomeScreen());
          }
        }


      });

      // Future.delayed(const Duration(seconds: 1),(){
      //   if(driverExists2==false){
      //     print("Drivers Exists Status : ${driverExists.value}");
      //     Get.off(() => HomeScreen());
      //   }else{
      //     Get.off(()=> const DriverHomeScreen());
      //   }
      // });
    }
  }

  _handleInternetIssue(bool internet) {
    if (internet == false) {
      _hasInternet.value = false;
    } else {
      _hasInternet.value = true;
    }
  }

  Future<bool> checkUserExistence2(String phoneNumber) async {
    final res = await FirebaseFirestore.instance
        .collection("users")
        .where("phoneNo", isEqualTo: phoneNumber)
        .get()
        .then((query) {
      var users = query.docs.map((e) => UserDetails.fromDocument(e)).toList();
      return users;
    });
    print("result of checkUserExistence2:${res.length}");
    bool existenceOfUser = res.isNotEmpty;
    return existenceOfUser;
  }

  Future<bool> checkDriverExistence(String phoneNumber) async {
    final res = await FirebaseFirestore.instance
        .collection("drivers")
        .where("phoneNo", isEqualTo: phoneNumber)
        .get()
        .then((query) {
      var users = query.docs.map((e) => DriverDetails.fromDocument(e)).toList();
      return users;
    });
    print("result of checkDriverExistence:${res.length}");
    bool existenceOfUser = res.isNotEmpty;
    return existenceOfUser;
  }
}
