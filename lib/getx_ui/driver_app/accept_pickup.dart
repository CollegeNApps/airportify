import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/widgets.dart';

class AcceptPickup extends StatelessWidget {
  final int index;
  const AcceptPickup({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // stepper widget mimic
                CustomStepper(width: w, pageIndex: 0),
                const SizedBox(
                  height: 20,
                ),
                //Location
                Text(
                  "Location",
                  style: textTheme.headline1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("images/terminal.png"),
                    const Positioned(top: 60, child: Text("\$TERMINAL")),
                  ],
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
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 5),
                          blurRadius: 5,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$airline \$name",
                              // flight.airline.toString() + ' ' + flight.name.toString(),
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
                                  // color: fb.flightStatusCodeColors[
                                  //     flight.statusCode!.toInt() - 1]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    "\${flight.status}",
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
                                      "Arrival Time: \${flight.at}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Airline: \${flight.airline}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "From: \${flight.from}",
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
                                        "Capacity : \${flight.capacity}",
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
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 5),
                          blurRadius: 5,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Id : \$id",
                              // flight.airline.toString() + ' ' + flight.name.toString(),
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
                                    Text(
                                      "Ordered By: \${Orderby}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "No. of adults: \${nos}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "No. of carrybags: \${nos}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "PickUp Time: \${time}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "No. of kids: \${kids}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "No. of suitcases: \${nos}",
                                      style: textTheme.headline1!
                                          .copyWith(fontSize: 14),
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
                )
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.amber,
            onTap: () {
              return;

              // uncomment for integration

              // if (fb.serviceType.value != 0 && fb.journeyType.value != 0) {
              //   Get.to(() => BuggyInfoScreen(
              //         flight: flight,
              //       ));
              // } else {
              //   Fluttertoast.showToast(
              //       msg: 'Please select journey and service type',
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.SNACKBAR,
              //       timeInSecForIosWeb: 1,
              //       backgroundColor: Colors.black,
              //       textColor: Colors.white,
              //       fontSize: 16.0);
              // }
            },
            child: SizedBox(
              width: w,
              height: h * 0.06,
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
