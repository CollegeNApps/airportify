import 'package:airportify/getx_ui/driver_app/accept_pickup.dart';
import 'package:airportify/getx_ui/driver_app/driver_home.dart';
import 'package:airportify/getx_ui/driver_app/on_the_way.dart';
import 'package:airportify/getx_ui/driver_app/ride_complete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/widgets.dart';

class DriverStatus extends StatefulWidget {
  final int index;
  const DriverStatus({Key? key, required this.index}) : super(key: key);

  @override
  State<DriverStatus> createState() => _DriverStatusState();
}

class _DriverStatusState extends State<DriverStatus> {
  late PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFf5f5f5),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFf5f5f5),
              child: Column(
                children: const [],
              ),
            ),
          )
        ],
        body: Container(
          color: const Color(0xFFf5f5f5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // stepper widget mimic
              CustomStepper(width: w, pageIndex: pageIndex),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: PageView(
                  // clipBehavior: Clip.none, allowImplicitScrolling: false,
                  // padEnds: true,
                  onPageChanged: (value) => setState(() {
                    pageIndex = value;
                  }),
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    AcceptPickup(
                      index: widget.index,
                    ),
                    OneTheWayPage(index: widget.index),
                    RideComplete(index: widget.index)
                  ],
                ),
              )
            ],
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
              if (pageController.page == 1) {
                if (!validateOnTheWay()) return;
              }

              if (pageController.page == 2) {
                Get.offAll(const DriverHomeScreen());
              }

              pageController.animateToPage(pageIndex + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn);

              // pageController.jumpToPage(1);

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
              child: Center(
                child: Text(
                  pageIndex == 2 ? "Finish" : 'Next',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
