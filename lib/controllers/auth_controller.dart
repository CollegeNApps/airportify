

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../getx_ui/client_app/home_screen.dart';
import '../getx_ui/phone_login_screen.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  late StreamSubscription subscription;
  var _hasInternet = false.obs;
  bool get hasInternet => _hasInternet.value;
  var signedInBool = true.obs;
  RxBool adminPass = false.obs;

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

    ever(_hasInternet,_handleInternetIssue);
    ever(_user,_initializeApp);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    subscription.cancel();
  }

  _initializeApp(User? user){
    if(user==null){
      print("Go to login page");
      Get.offAll(()=>PhoneLoginScreen());
    }else{
      print("Go to home page");
      Get.off(()=>HomeScreen());
    }
  }

  _handleInternetIssue(bool internet){
    if(internet==false){
      _hasInternet.value = false;
    }else{
      _hasInternet.value = true;
    }
  }

}