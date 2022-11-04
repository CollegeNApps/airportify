import 'package:airportify/getx_ui/client_app/client_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: h * 0.4,
          ),
          Center(
            child: CircleAvatar(
                radius: w * 0.2,
                backgroundColor: Theme.of(context).primaryColor,
                child: Lottie.asset('images/lottie/lf30_editor_0imp56vx.json')),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Booking Confirmed",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Center(
            child: InkWell(
              onTap: () => Get.offAll(() => ClientHomeScreen()),
              child: Container(
                  width: w * 0.5,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
