import 'package:airportify/controllers/firebase_controller.dart';
import 'package:airportify/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'getx_ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => {
    Future.delayed(const Duration(seconds: 3)).then((value) => Get.put(AuthController()))
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FirebaseController fb = Get.put(FirebaseController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      defaultTransition: Transition.rightToLeftWithFade,
      themeMode: ThemeMode.light,
      theme: T1.themeData(),
      home: const SplashScreen(),
    );
  }
}
