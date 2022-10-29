import 'package:airportify/controllers/firebase_controller.dart';
import 'package:airportify/models/flight_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buggy_info.dart';

class FlightInfoScreen extends StatelessWidget {
  final index;
  FlightInfoScreen({Key? key, this.index}) : super(key: key);


  final FirebaseController fb = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final flight = fb.flights[index];

    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.to(() => BuggyInfoScreen(flight: flight,));
        },
        child: Container(
          width: w,
          height: h * 0.06,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: const Center(
            child: Text(
              'Next',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: size.height * 0.35,
                child: Hero(
                    tag: "flightImage$index",
                    child: Image.network(flight.image.toString(),fit: BoxFit.contain,)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //info card
                  flightInfoCard(w,h,context,flight),

                  const SizedBox(
                    height: 20,
                  ),
                  //services provided

                  Text(
                    "Choose your journey type",
                    style: textTheme.headline1!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetX<FirebaseController>(
                    builder: (ctrl1) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildJourneyCard(w, h, context, 'images/arrival.jpg', 'Arrival',1,ctrl1),
                          buildJourneyCard(w, h, context, 'images/transit.jpg', 'Transit',2,ctrl1),
                          buildJourneyCard(w, h, context, 'images/departure.jpg', 'Departure',3,ctrl1),
                        ],
                      );
                    }
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //services provided

                  Text(
                    "Choose your service",
                    style: textTheme.headline1!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetX<FirebaseController>(
                    builder: (ctrl2) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildServiceCard(w, h, context, 'images/buggy2.jpg', 'Book a buggy',1,ctrl2),
                          buildServiceCard(w, h, context, 'images/porter2.jpg', 'Book a porter',2,ctrl2),
                        ],
                      );
                    }
                  ),

                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  InkWell buildJourneyCard(double w, double h, BuildContext context, String image, String text,int option,FirebaseController ctrl) {
    return InkWell(
      onTap: (){
        ctrl.journeyType.value = option;
      },
      child: Container(
        width: w * 0.28,
        height: h * 0.21,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: h * 0.16,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover,opacity:ctrl.journeyType.value==option?1:0.5),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const Spacer(),
            Container(
              height: h * 0.03,
              decoration: BoxDecoration(
                  color:ctrl.journeyType.value==option? Theme.of(context).primaryColor:Colors.grey,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  text,
                  style:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell buildServiceCard(double w, double h, BuildContext context, String image, String text, int option,FirebaseController ctrl) {
    return InkWell(
      onTap: (){
        ctrl.serviceType.value = option;
      },
      child: Container(
        width: w * 0.42,
        height: h * 0.22,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0)
            ]),
        child: Column(
          children: [
            Container(
              height: h * 0.16,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.contain,opacity:ctrl.serviceType.value==option?1:0.5),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: w * 0.35,
              height: h * 0.03,
              decoration: BoxDecoration(
                  color: ctrl.serviceType.value==option?Theme.of(context).primaryColor:Colors.grey,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  text,
                  style:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget flightInfoCard(double w, double h,BuildContext context, FlightInfo flight) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      // height: 100,
      height: h*0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 5),
          blurRadius: 5,
        )
      ],
          borderRadius: BorderRadius.circular(10), color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  flight.airline.toString()+' '+flight.name.toString(),
                  style: textTheme.headline1!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: fb.flightStatusCodeColors[flight.statusCode!.toInt() -1]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "${flight.status}",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.black,
                            fontSize: 14),
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Arrival Time: ${flight.at}",
                          style: textTheme.headline1!.copyWith(
                            fontSize: 14
                          ),
                        ),
                        const SizedBox(height: 5,),

                        Text(
                          "Airline: ${flight.airline}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14
                          ),
                        ),
                        const SizedBox(height: 5,),

                        Text(
                          "From: ${flight.from}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14
                          ),
                        ),
                        const SizedBox(height: 5,),

                        Text(
                          "ICAO: ${flight.icao}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Call Sign : ${flight.callSign}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14
                          ),
                        ),
                        const SizedBox(height: 5,),

                        Text(
                          "Aircraft: ${flight.aircraft}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14
                          ),
                        ),
                        const SizedBox(height: 5,),

                        Text(
                          "To : ${flight.to}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 5,),

                        Text(
                          "Capacity : ${flight.capacity}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
