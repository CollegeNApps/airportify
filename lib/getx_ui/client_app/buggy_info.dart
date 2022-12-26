import 'dart:math';

import 'package:airportify/controllers/auth_controller.dart';
import 'package:airportify/controllers/firebase_controller.dart';
import 'package:airportify/controllers/razorpay_controller.dart';
import 'package:airportify/getx_ui/client_app/confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/flight/flight_info.dart';

class BuggyInfoScreen extends StatefulWidget {
  final FlightInfo flight;
  const BuggyInfoScreen({Key? key, required this.flight}) : super(key: key);

  @override
  State<BuggyInfoScreen> createState() => _BuggyInfoScreenState();
}

class _BuggyInfoScreenState extends State<BuggyInfoScreen> {

  final RazorpayController razorpayController = Get.put(RazorpayController());

  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController adultController = TextEditingController();
  final TextEditingController kidsController = TextEditingController();
  final TextEditingController carryBagController = TextEditingController();
  final TextEditingController suitcaseController = TextEditingController();

  final FocusNode dateTimeNode = FocusNode();
  final FocusNode adultNode = FocusNode();
  final FocusNode kidsNode = FocusNode();
  final FocusNode carryBagNode = FocusNode();
  final FocusNode suitcaseNode = FocusNode();

  String date = '';
  String time = '';

  int finalAmount = 0;

  final FirebaseController fb = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final FlightInfo flight = widget.flight;

    String serviceImage =
        fb.serviceType.value == 1 ? 'images/buggy2.jpg' : 'images/porter2.jpg';
    String buggyOrPorter = fb.serviceType.value == 1 ? 'buggy' : 'porter';

    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          if (buggyOrPorter == 'buggy') {
            if (dateTimeController.text.isNotEmpty &&
                adultController.text.isNotEmpty &&
                kidsController.text.isNotEmpty) {
              openModalBottomSheet(
                context,
                w,
                h,
              );
            } else {
              Fluttertoast.showToast(
                  msg: 'Please enter all the fields',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            if (dateTimeController.text.isNotEmpty &&
                carryBagController.text.isNotEmpty &&
                suitcaseController.text.isNotEmpty) {
              openModalBottomSheet(
                context,
                w,
                h,
              );
            } else {
              Fluttertoast.showToast(
                  msg: 'Please enter all the fields',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        child: Container(
          width: w,
          height: h * 0.06,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: const Center(
            child: Text(
              'Proceed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      // backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          dateTimeNode.unfocus();
          adultNode.unfocus();
          kidsNode.unfocus();
          carryBagNode.unfocus();
          suitcaseNode.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * 0.35,
                    width: w,
                    child: Image.asset(
                      serviceImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    "Good news",
                    style: textTheme.headline1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'There are 5 $buggyOrPorter services avaialble nearby',
                    style: textTheme.headline1!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w,
                    // height: h*0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pick up date and time",
                              style: textTheme.headline1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: w * 0.8,
                              height: 40,
                              child: TextFormField(
                                controller: dateTimeController,
                                focusNode: dateTimeNode,
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  filled: false,
                                  hintText: 'Date Time',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.solid)),
                                ),
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                                onTap: () {
                                  _pickDateTime();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buggyOrPorter == 'buggy'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Adults",
                                            style: textTheme.headline1,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: 40,
                                            child: TextFormField(
                                              controller: adultController,
                                              focusNode: adultNode,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                filled: false,
                                                hintText: 'No of adults',
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            style: BorderStyle
                                                                .solid)),
                                              ),
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: false),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Kids (Below 5 yrs)",
                                            style: textTheme.headline1,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: 40,
                                            child: TextFormField(
                                              controller: kidsController,
                                              focusNode: kidsNode,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                filled: false,
                                                hintText: 'No of kids',
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            style: BorderStyle
                                                                .solid)),
                                              ),
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: false),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Row(),
                            const SizedBox(
                              height: 10,
                            ),
                            buggyOrPorter == 'porter'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Carry Bags",
                                            style: textTheme.headline1,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: 40,
                                            child: TextFormField(
                                              controller: carryBagController,
                                              focusNode: carryBagNode,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                filled: false,
                                                hintText: 'No of carry bags',
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            style: BorderStyle
                                                                .solid)),
                                              ),
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: false),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Suitcases",
                                            style: textTheme.headline1,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: 40,
                                            child: TextFormField(
                                              controller: suitcaseController,
                                              focusNode: suitcaseNode,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                filled: false,
                                                hintText: 'No of suitcases',
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            style: BorderStyle
                                                                .solid)),
                                              ),
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: false),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Row()
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Flight Info",
                    style: textTheme.headline1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  flightInfoCard(w, h, context, flight),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget flightInfoCard(
      double w, double h, BuildContext context, FlightInfo flight) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      // height: 100,
      height: h * 0.2,
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
                  flight.airline.toString() + ' ' + flight.name.toString(),
                  style: textTheme.headline1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: fb.flightStatusCodeColors[
                            flight.statusCode!.toInt() - 1]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "${flight.status}",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.black, fontSize: 14),
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
                          "Arrival Time: ${flight.at}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Airline: ${flight.airline}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "From: ${flight.from}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "ICAO: ${flight.icao}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Call Sign : ${flight.callSign}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Aircraft: ${flight.aircraft}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "To : ${flight.to}",
                          style: textTheme.headline1!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Capacity : ${flight.capacity}",
                          style: textTheme.headline1!.copyWith(fontSize: 14),
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

  Future<DateTime?> _pickDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
  }

  Future<TimeOfDay?> _pickTime() {
    return showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );
  }

  void _pickDateTime() async {
    final datePicked = await _pickDate();
    if (datePicked != null) {
      setState(() {
        date = DateFormat('EEE, MMM d, ' 'yyy ').format(datePicked).toString();
      });
    }

    final timePicked = await _pickTime();
    if (timePicked != null) {
      setState(() {
        if (timePicked.hour > 12) {
          time = timePicked.minute < 10
              ? "${timePicked.hour - 12}:0${timePicked.minute} ${timePicked.period.name}"
              : "${timePicked.hour - 12}:${timePicked.minute} ${timePicked.period.name}";
        } else {
          time = timePicked.minute < 10
              ? "${timePicked.hour - 12}:0${timePicked.minute} ${timePicked.period.name}"
              : "${timePicked.hour}:${timePicked.minute} ${timePicked.period.name}";
        }
      });
      print("$date \n Time: $time");
      dateTimeController.text = " $date  @$time";
      dateTimeNode.unfocus();
    }
  }

  openModalBottomSheet(BuildContext context, double w, double h) {
    String serviceType = '';
    String journeyType = '';

    if (fb.serviceType.value == 1) {
      serviceType = 'Buggy';
    } else {
      serviceType = 'Porter';
    }

    if (fb.journeyType.value == 1) {
      journeyType = 'Arrival';
    } else if (fb.journeyType.value == 2) {
      journeyType = 'Transit';
    } else {
      journeyType = 'Departure';
    }

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          var t1 = Theme.of(context).textTheme.headline1;
          var t2 = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
          return Container(
            width: w,
            height: h,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Confirmation",
                    style:
                        t1!.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("Service Type  : ", style: t2),
                      Container(
                        width: w * 0.23,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            serviceType,
                            style: t2.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Journey Type : ", style: t2),
                      Container(
                        width: w * 0.23,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            journeyType,
                            style: t2.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Location : ${widget.flight.to}", style: t2),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: w * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date : $date",
                          style: t2,
                        ),
                        Text(
                          "Time : $time",
                          style: t2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  serviceType == 'Buggy'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$serviceType Details',
                              style: t2.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "No of Adults: ${adultController.text}",
                              style: t2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "No of kids : ${kidsController.text}",
                              style: t2,
                            ),
                          ],
                        )
                      : Row(),
                  serviceType == 'Porter'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$serviceType Details',
                              style: t2.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "No of carry bags : ${carryBagController.text}",
                              style: t2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "No of suitcases/kitbags : ${suitcaseController.text}",
                              style: t2,
                            ),
                          ],
                        )
                      : Row(),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pricing Details",
                    style:
                        t2.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildPriceBlock(serviceType),
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        FlightInfo f = widget.flight;

                        if (serviceType == 'Buggy') {
                          await FirebaseFirestore.instance
                              .collection('bookings')
                              .doc()
                              .set({
                            'serviceType': serviceType,
                            'adults': int.parse(adultController.text),
                            'airline': f.airline,
                            'at': f.at,
                            'capacity': f.capacity,
                            'carrybags': 0,
                            'flightName': f.name,
                            'flightStatus': f.status,
                            'flightStatusCode': f.statusCode,
                            'from': f.from,
                            'kids': int.parse(kidsController.text),
                            'orderedBy':
                                AuthController.firebaseUser.username.toString(),
                            'pickUpTime': dateTimeController.text,
                            'suitcases': 0,
                            "gateNo": f.gateNo
                          });
                        } else {
                          await FirebaseFirestore.instance
                              .collection('bookings')
                              .doc()
                              .set({
                            'serviceType': serviceType,
                            'adults': 0,
                            'airline': f.airline,
                            'at': f.at,
                            'capacity': f.capacity,
                            'carrybags': int.parse(carryBagController.text),
                            'flightName': f.name,
                            'flightStatus': f.status,
                            'flightStatusCode': f.statusCode,
                            'from': f.from,
                            'kids': 0,
                            'orderedBy':
                                AuthController.firebaseUser.username.toString(),
                            'pickUpTime': dateTimeController.text,
                            'suitcases': int.parse(suitcaseController.text),
                            "gateNo": f.gateNo
                          });
                        }

                        print("Booking Upload complete");
                        // Get.to(() => const ConfirmationScreen());
                        razorpayController.openCheckout(
                            'Booking No : ${Random().nextInt(1000)}',finalAmount ,
                            FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                            'something@gmail.com',
                            ["Gpay","paytm","PhonePe"],
                            '7411481997');

                      },
                      child: Container(
                        width: w,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 2),
                                  blurRadius: 2,
                                  spreadRadius: 0)
                            ]),
                        child: Center(
                          child: Text(
                            "Confirm Booking",
                            style: t2.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Row buildPriceRow(String heading, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        Text(price,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15))
      ],
    );
  }

  buildPriceBlock(String serviceType) {
    int pricePerAdult = 50;
    int pricePerKid = 25;
    int pricePerCarryBag = 25;
    int pricePerSuitcase = 50;
    int serviceCharge = 20;

    if (serviceType == 'Buggy') {
      int subtotal = (pricePerAdult * int.parse(adultController.text)) + (pricePerKid * int.parse(kidsController.text));
      int overallTotal = subtotal + serviceCharge;

      finalAmount =  overallTotal;
      print("Buggy Final Amount :$finalAmount");

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Per Adult : Rs 50 | Per Kid : Rs 25",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          buildPriceRow('SubTotal', 'Rs $subtotal'),
          const SizedBox(
            height: 5,
          ),
          buildPriceRow('Service Charges', 'Rs 20'),
          const SizedBox(
            height: 5,
          ),
          buildPriceRow('Overall Total', 'Rs $overallTotal'),
        ],
      );
    } else {
      int subtotal = (pricePerSuitcase * int.parse(suitcaseController.text)) + (pricePerCarryBag * int.parse(carryBagController.text));
      int overallTotal = subtotal + serviceCharge;

      print("Porter final Amount:$finalAmount");
      finalAmount = overallTotal;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Per Suitcase : Rs 50 | Per Carrybag  : Rs 25",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          buildPriceRow('SubTotal', 'Rs $subtotal'),
          const SizedBox(
            height: 5,
          ),
          buildPriceRow('Service Charges', 'Rs 20'),
          const SizedBox(
            height: 5,
          ),
          buildPriceRow('Overall Total', 'Rs $overallTotal'),
        ],
      );
    }
  }
}
