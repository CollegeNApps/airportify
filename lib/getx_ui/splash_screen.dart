

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final t = Theme.of(context);
    final s = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'images/lottie/44383-multi-a.json',
            fit: BoxFit.cover,
          ),
          Text("Airportify",style: Theme.of(context).textTheme.caption!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),)


        ],
      )
    );
  }
}
