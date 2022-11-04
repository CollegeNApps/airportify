import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(width: w*0.08,),
                Column(
                  children: const [
                    CircleAvatar(
                        radius: 15,
                        child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Color(0xff204D5B),
                            child: Icon(
                              Icons.person_outline,
                              size: 25,
                            ))),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "About you",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                // SizedBox(width: w*0.23,),
                // Column(
                //   children: [
                //     selectedStep>0?Icon(Icons.insert_chart_outlined,color: borderColor,size: 25,):
                //     Icon(Icons.insert_chart_outlined,color: unselectedColor,size: 25,),
                //     const SizedBox(height: 2,),
                //     selectedStep>0?Text("Status",style: TextStyle(
                //         fontSize: 12,
                //         color: borderColor
                //     ),):Text("Status",style: TextStyle(
                //         fontSize: 12,
                //         color: unselectedColor
                //     ),)
                //   ],
                // ),
                // SizedBox(width: w*0.23,),
                // Column(
                //   children: [
                //     selectedStep>1?Icon(Icons.star_border_outlined,color: borderColor,size: 25,):
                //     Icon(Icons.star_border_outlined,color: unselectedColor,size: 25,),
                //     const SizedBox(height: 2,),
                //     selectedStep>1?Text("Interests",style: TextStyle(
                //         fontSize: 12,
                //         color: borderColor
                //     ),):Text("Interests",style: TextStyle(
                //         fontSize: 12,
                //         color: unselectedColor
                //     ),)
                //   ],
                // )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StepsIndicator(
              nbSteps: 3,
              selectedStep: 1,
              // selectedStepColorOut: borderColor,
              // selectedStepColorIn: borderColor,
              // doneStepColor: borderColor,
              // doneLineColor: borderColor,
              // undoneLineColor: unselectedColor,
              isHorizontal: true,
              lineLength: 100,
              unselectedStepSize: 12,
              selectedStepSize: 10,

              // These two are border colors
              // unselectedStepColorIn: unselectedColor,
              // unselectedStepColorOut: unselectedColor,
              // enableLineAnimation: true,
              // enableStepAnimation: true,
            ),
          ],
        ),
      ),
    );
  }
}
