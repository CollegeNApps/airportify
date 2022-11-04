

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/theme.dart';

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
          // SizedBox(
          //   width: w,
          //   child: DefaultTextStyle(
          //     style: t.textTheme.caption!.copyWith(color: Colors.black),
          //     child: Center(
          //       child: AnimatedTextKit(
          //         animatedTexts: [
          //           ScaleAnimatedText('Airportify',scalingFactor: 0.8,duration: const Duration(seconds: 5)),
          //         ],
          //         onTap: () {
          //           print("Tap Event");
          //         },
          //       ),
          //     ),
          //   ),
          // ),
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
