// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:airportify/models/user/bookings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/firebase_controller.dart';

class AcceptPickup extends StatefulWidget {
  final int index;
  AcceptPickup({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<AcceptPickup> createState() => _AcceptPickupState();
}

class _AcceptPickupState extends State<AcceptPickup> {
  final FirebaseController fb = Get.find();
  double size = 54;
  Color color = Color.fromARGB(255, 17, 84, 207);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    increaseSize();
  }

  increaseSize() async {
    await Future.delayed(Duration(milliseconds: 800));
    setState(() {
      size = 14;
      color = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    final BookingInfo bookingInfo = fb.bookings[widget.index];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Location
            Text(
              "Location",
              style: textTheme.headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("images/terminal.png"),
                  Positioned(
                      top: 60,
                      child: AnimatedDefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: size, color: color),
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "TERMINAL: ${bookingInfo.gateNo}",
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //Flight details
            //Modularize after integration
            Text(
              "Flight Details",
              style: textTheme.headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // height: 100,
              // height: h * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 5),
                  blurRadius: 5,
                )
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          // "\$airline \$name",
                          bookingInfo.airline.toString() +
                              ' ' +
                              bookingInfo.flightName.toString(),
                          style: textTheme.headline1!.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                //uncomment the below lines while integration
                                color: fb.flightStatusCodeColors[
                                    bookingInfo.flightStatusCode!.toInt() - 1]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                "${bookingInfo.flightStatus}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Colors.black, fontSize: 14),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                                  "Arrival Time: ${bookingInfo.at}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Airline: ${bookingInfo.airline}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "From: ${bookingInfo.from}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),

                                //remove the size box while integration ... unnecessary
                                SizedBox(
                                  width: w * 0.42,
                                  child: Text(
                                    "Capacity : ${bookingInfo.capacity}",
                                    style: textTheme.headline1!
                                        .copyWith(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
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
            ),
            const SizedBox(
              height: 20,
            ),

            //PickUp details

            Text(
              "Pick up details",
              style: textTheme.headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // height: 100,
              // height: h * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 5),
                  blurRadius: 5,
                )
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          // "Order Id : $id",
                          bookingInfo.airline.toString() +
                              ' ' +
                              bookingInfo.flightName.toString(),
                          style: textTheme.headline1!.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Ordered By: ",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                      "${bookingInfo.orderedBy}",
                                      style: textTheme.headline1!.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "No. of adults: ${bookingInfo.adults}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "No. of carrybags: ${bookingInfo.carryBags}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "No. of kids: ${bookingInfo.kids}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "No. of suitcases: ${bookingInfo.suitcases}",
                                  style: textTheme.headline1!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "PickUp Time: ${bookingInfo.pickupTime}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
