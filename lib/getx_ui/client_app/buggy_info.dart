

import 'package:airportify/controllers/firebase_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/flight_info.dart';

class BuggyInfoScreen extends StatefulWidget {
  final FlightInfo flight;
  const BuggyInfoScreen({Key? key,required this.flight}) : super(key: key);

  @override
  State<BuggyInfoScreen> createState() => _BuggyInfoScreenState();
}

class _BuggyInfoScreenState extends State<BuggyInfoScreen> {

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

  final FirebaseController fb = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final FlightInfo flight = widget.flight;

    return Scaffold(

      bottomNavigationBar: InkWell(
        child: Container(
          width: w,
          height: h*0.06,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: const Center(child: Text('Confirm Booking',style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),),
        ),
      ),

      body: GestureDetector(
        onTap: (){
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
                    child: Image.asset('images/buggy.png',fit: BoxFit.scaleDown,),
                  ),
                  Text("Good news",style: textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  const SizedBox(height: 5,),
                  Text('There are 5 buggy services avaialble nearby',style: textTheme.headline1!.copyWith(
                    fontSize: 14
                  ),),
                  const SizedBox(height: 10,),

                  Container(
                    width: w,
                    height: h*0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0,2),
                          blurRadius: 4,
                          spreadRadius: 0
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pick up date and time",style: textTheme.headline1,),
                          const SizedBox(height: 5,),
                          SizedBox(
                            width: w*0.8,
                            height: 40,
                            child: TextFormField(
                              controller: dateTimeController,
                              focusNode: dateTimeNode,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black
                                  )
                                ),
                                filled: false,
                                hintText: 'Date Time',
                                hintStyle: const TextStyle(
                                  fontSize: 14
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    style: BorderStyle.solid
                                  )
                                ),
                              ),
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              onTap: (){
                                _pickDateTime();
                              },
                            ),
                          ),

                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Adults",style: textTheme.headline1,),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: w*0.4,
                                    height: 40,
                                    child: TextFormField(
                                      controller: adultController,
                                      focusNode: adultNode,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        ),
                                        filled: false,
                                        hintText: 'No of adults',
                                        hintStyle: const TextStyle(
                                            fontSize: 14
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                style: BorderStyle.solid
                                            )
                                        ),
                                      ),
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      textInputAction: TextInputAction.next,
                                      onTap: (){

                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kids (Below 5 yrs)",style: textTheme.headline1,),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: w*0.4,
                                    height: 40,
                                    child: TextFormField(
                                      controller: kidsController,
                                      focusNode: kidsNode,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        ),
                                        filled: false,
                                        hintText: 'No of kids',
                                        hintStyle: const TextStyle(
                                            fontSize: 14
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                style: BorderStyle.solid
                                            )
                                        ),
                                      ),
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      textInputAction: TextInputAction.next,
                                      onTap: (){

                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Carry Bags",style: textTheme.headline1,),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: w*0.4,
                                    height: 40,
                                    child: TextFormField(
                                      controller: carryBagController,
                                      focusNode: carryBagNode,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        ),
                                        filled: false,
                                        hintText: 'No of carry bags',
                                        hintStyle: const TextStyle(
                                            fontSize: 14
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                style: BorderStyle.solid
                                            )
                                        ),
                                      ),
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      textInputAction: TextInputAction.next,
                                      onTap: (){

                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Suitcases",style: textTheme.headline1,),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: w*0.4,
                                    height: 40,
                                    child: TextFormField(
                                      controller: suitcaseController,
                                      focusNode: suitcaseNode,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        ),
                                        filled: false,
                                        hintText: 'No of suitcases',
                                        hintStyle: const TextStyle(
                                            fontSize: 14
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                style: BorderStyle.solid
                                            )
                                        ),
                                      ),
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      textInputAction: TextInputAction.next,
                                      onTap: (){

                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )

                        ],
                      ),
                    ),

                  ),
                  const SizedBox(height: 20,),
                  Text("Flight Info",style: textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                  const SizedBox(height: 10,),
                  flightInfoCard(w, h, context,flight),
                  const SizedBox(height: 25,),
                ],
              ),
            ),
          ),
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


  Future<DateTime?> _pickDate(){
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.yellow, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
    );
  }

  Future<TimeOfDay?> _pickTime(){
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour,
            minute: DateTime.now().minute),
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
          time =
          "${timePicked.hour - 12}:${timePicked.minute} ${timePicked.period
              .name}";
        } else {
          time =
          "${timePicked.hour}:${timePicked.minute} ${timePicked.period.name}";
        }
      });
      print("$date \n Time: $time");
      dateTimeController.text = " $date  @$time";
      dateTimeNode.unfocus();
    }
  }

}
