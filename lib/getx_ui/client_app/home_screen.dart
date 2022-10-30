import 'package:airportify/controllers/auth_controller.dart';
import 'package:airportify/controllers/firebase_controller.dart';
import 'package:airportify/getx_ui/client_app/flight_info.dart';
import 'package:airportify/models/flight_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key:key);

  final FirebaseController fb = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final user = AuthController.firebaseUser;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              title: Text(
                "Hi ${user.username}",
                style: textTheme.headline1!.copyWith(color: Colors.black,fontWeight: FontWeight.w500),
              ),
              actions: [
                IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.notifications_outlined, color: Colors.black)),
                IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.account_circle, color: Colors.black)),
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: size.height * 0.32,
                  child: Image.asset(
                    "images/airport image.gif",
                    fit: BoxFit.fitHeight,
                  )),
            ),
          ];
        },
        body: PhysicalModel(
          color: Colors.transparent,
          elevation: 5,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Flights",
                      style: textTheme.headline1!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    GetX<FirebaseController>(
                      builder: (ctrl) {
                        return Expanded(
                          child: SizedBox(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: ctrl.flights.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  FlightInfo flight = ctrl.flights[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                    child: InkWell(
                                      onTap: (){
                                        Get.to(()=> FlightInfoScreen(index: index,));
                                      },
                                      child: Container(
                                        width: w,
                                        height: h*0.11,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.5),
                                              offset: const Offset(0,1),
                                              blurRadius: 2,
                                              spreadRadius: 0
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Hero(
                                                tag: 'flightImage$index',
                                                child: ClipOval(
                                                  child: CircleAvatar(
                                                    radius: w*0.1,
                                                    backgroundColor: Colors.white,
                                                    child: Image.network(flight.image.toString(),fit: BoxFit.contain,),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(flight.name.toString(), style: textTheme.headline1!.copyWith(
                                                    fontSize: 15
                                                  ),),
                                                  const SizedBox(height: 5,),
                                                  Text("Arrival Time : ${flight.at}",style: textTheme.headline1!.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal
                                                  ),),
                                                  // SizedBox(width: w*0.08,),
                                                  const SizedBox(height: 5,),
                                                  Text("From : ${flight.from}",style: textTheme.headline1!.copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal
                                                  ),),

                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 5),
                                                child: Column(
                                                  children: [
                                                    Text('', style: textTheme.headline1!.copyWith(
                                                        fontSize: 15
                                                    ),),
                                                    const SizedBox(height: 5,),
                                                    Text("Airline : ${flight.airline}",style: textTheme.headline1!.copyWith(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal
                                                    ),),
                                                    const SizedBox(height: 5,),

                                                    Container(
                                                      width: w*0.23,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: ctrl.flightStatusCodeColors[flight.statusCode!.toInt()-1],
                                                          borderRadius: BorderRadius.circular(4)
                                                      ),
                                                      child: Center(child: Text("${flight.status}",style: textTheme.headline1!.copyWith(
                                                          fontSize: 12
                                                      ),),),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}