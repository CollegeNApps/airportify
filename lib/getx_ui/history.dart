

import 'package:airportify/controllers/firebase_controller.dart';
import 'package:airportify/models/user/bookings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatelessWidget {
  final bool driverAccess;
  final List<BookingInfo> history;
  History({Key? key,required this.driverAccess,required this.history}) : super(key: key);

  final FirebaseController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {


    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.chevron_left),iconSize: 25,color: Colors.black,),
        title:driverAccess==true?const Text("Ride History",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22
        ),):const Text("Booking History",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22
        ),),
        titleSpacing: 0,
      ),
      body: SizedBox(
        width: w,
        child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context,index){
              BookingInfo h = history[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: w,
                  height: w*0.35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Airline: ${h.airline} (${h.flightName})",style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            )),
                            Container(
                              width: w * 0.23,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: ctrl.flightStatusCodeColors[h.flightStatusCode!.toInt() - 1],
                                  borderRadius:
                                  BorderRadius
                                      .circular(4)),
                              child: Center(
                                child: Text(
                                  "${h.flightStatus}",
                                  style: Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 12
                                  )
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Arrival Time: ${h.at}",style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                            )),
                            Text(
                                "Gate No: ${h.gateNo}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                )
                            ),
                            Text(
                                "From: ${h.from}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                )
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text("Arrival Time: ${h.at}",style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        )),
                        const SizedBox(height: 10,),
                        buildTwoInOneRow(w,h)
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  Row buildTwoInOneRow(double w,BookingInfo h) {
    if (h.kids==0) {
      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Carry Bags: ${h.carryBags}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  )
                              ),
                              const SizedBox(width: 20,),
                              Text(
                                  "Suitcases: ${h.suitcases}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  )
                              )
                            ],
                          ),
                          buildAmountContainer(w, calculatePricing('Porter', h.carryBags!, h.suitcases!))
                        ],
                      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                  "Adults: ${h.adults}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                  )
              ),
              const SizedBox(width: 20,),

              Text(
                  "Kids: ${h.kids}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                  )
              )
            ],
          ),
          buildAmountContainer(w, calculatePricing('Porter', h.adults!, h.kids!))

        ],
    );
    }
  }

  int calculatePricing(String type,int value1,int value2){
    int pricePerAdult = 50;
    int pricePerKid = 25;
    int pricePerCarryBag = 25;
    int pricePerSuitcase = 50;
    int serviceCharge = 20;

    if(type=='Porter'){
      return ((value1*pricePerAdult) + (value2*pricePerKid));
    }else{
      return ((value1*pricePerCarryBag) + (value2*pricePerSuitcase));
    }
  }

  Container buildAmountContainer(double w,int price){
    return Container(
      width: w*0.25,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(child: Text("Paid: ₹$price",style:const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
      ),),),
    );
  }

}
