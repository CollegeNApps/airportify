import 'package:airportify/controllers/auth_controller.dart';
import 'package:airportify/getx_ui/client_app/flight_info.dart';
import 'package:airportify/getx_ui/driver_app/driver_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  // final FirebaseController fb = Get.find();
  late VideoPlayerController videoPlayerController;
  late Future<void> _initialiseVideo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.asset(
      "images/golf_cart.mp4",
    );
    _initialiseVideo = videoPlayerController.initialize();

    videoPlayerController.setLooping(false);
    videoPlayerController.setVolume(0);
    videoPlayerController.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

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
              automaticallyImplyLeading: false,
              // centerTitle: true,
              title: Text(
                "Hi ${user.username}",
                style: textTheme.headline1!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              actions: [
                IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.black)),
                IconButton(
                    onPressed: () => null,
                    icon:
                        const Icon(Icons.account_circle, color: Colors.black)),
              ],
            ),
            SliverToBoxAdapter(
                child: FutureBuilder(
              future: _initialiseVideo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController));
                } else {
                  return Container();
                }
              },
            )),
          ];
        },
        body: SafeArea(
          child: PhysicalModel(
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
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),

                      //uncomment and use below code for Firebase Integration
                      //the ending brackets are commented too
                      // GetX<FirebaseController>(builder: (ctrl) {
                      //   return
                      clientOrdersTile(w, h, textTheme)

                      //uncomment here to use the GetX widget
                      // })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clientOrdersTile(double w, double h, TextTheme textTheme) {
    return Expanded(
      child: SizedBox(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            //  ctrl.flights.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // FlightInfo flight = ctrl.flights[index];

              return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              blurRadius: 5,
                              spreadRadius: 0)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Get.to(() => DriverStatus(index: index));
                        },
                        child: SizedBox(
                          width: w,
                          // height: h * 0.11,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Hero(
                                  tag: 'flightImage$index',
                                  child: ClipOval(
                                    child: CircleAvatar(
                                        radius: w * 0.1,
                                        backgroundColor: Colors.white,
                                        child:
                                            // Image.network(
                                            //   flight.image
                                            //       .toString(),
                                            //   fit: BoxFit.contain,
                                            // ),
                                            Image.asset(
                                          "images/arrival.jpg",
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "flightname",
                                      // flight.name.toString(),
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Arrival Time : \$ArrivalTime",
                                      // "Arrival Time : ${flight.at}",
                                      style: textTheme.headline1!.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    // SizedBox(width: w*0.08,),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "From : \$placeName",
                                      // "From : ${flight.from}",
                                      style: textTheme.headline1!.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        '',
                                        style: textTheme.headline1!
                                            .copyWith(fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Airline : \$airline", // "Airline : ${flight.airline}",
                                        style: textTheme.headline1!.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: w * 0.23,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            // color: ctrl
                                            //     .flightStatusCodeColors[flight
                                            //         .statusCode!
                                            //         .toInt() -
                                            //     1],
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Text(
                                            "\${flight.status}",
                                            style: textTheme.headline1!
                                                .copyWith(fontSize: 12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
