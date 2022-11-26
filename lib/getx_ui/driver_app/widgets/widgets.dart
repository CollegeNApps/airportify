import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

Widget CustomStepper({required double width, required int pageIndex}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.2,
              child: Column(
                children: const [
                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Pick Up")
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: Column(
                children: [
                  SizedBox(
                    // color: Colors.amber,
                    height: 40,
                    width: 50,
                    child: Stack(children: [
                      Positioned(
                        // top: 5,
                        left: 5,
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 30,
                          color: pageIndex == 1 || pageIndex == 2
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      Positioned(
                        left: 25,
                        top: 15,
                        child: Icon(
                          Icons.timer,
                          size: 18,
                          color: pageIndex == 1 || pageIndex == 2
                              ? Colors.black
                              : Colors.grey,
                        ),
                      )
                    ]),
                  ),
                  const Text("Arriving")
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: Column(
                children: [
                  Icon(
                    Icons.done_all,
                    color: pageIndex == 2 ? Colors.black : Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Task done")
                ],
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      StepsIndicator(
        nbSteps: 3,
        selectedStep: pageIndex,
        lineLength: width * 0.35,
        doneLineColor: Colors.black,
        doneStepColor: Colors.black,
        undoneLineColor: Colors.grey,
        selectedStepColorIn: Colors.black,
        selectedStepBorderSize: 0,
        selectedStepSize: 10,
        unselectedStepColorIn: Colors.grey,
      )
    ],
  );
}
