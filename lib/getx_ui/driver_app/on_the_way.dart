// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OneTheWayPage extends StatefulWidget {
  final int index;

  const OneTheWayPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<OneTheWayPage> createState() => _OneTheWayPageState();
}

late TextEditingController adultTextController;
late TextEditingController kidsTextController;
late TextEditingController carryBagsController;
late TextEditingController suitCaseController;

validateOnTheWay() {
  if (adultTextController.text.isNotEmpty &&
      kidsTextController.text.isNotEmpty &&
      carryBagsController.text.isNotEmpty &&
      suitCaseController.text.isNotEmpty) {
    return true;
  } else {
    Fluttertoast.showToast(
        msg: 'Please enter all the fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  }
}

class _OneTheWayPageState extends State<OneTheWayPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adultTextController = TextEditingController();
    kidsTextController = TextEditingController();
    carryBagsController = TextEditingController();
    suitCaseController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adultTextController.dispose();
    kidsTextController.dispose();
    carryBagsController.dispose();
    suitCaseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    var enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    );
    var focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.amber),
    );
    var errorBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    );

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("images/OnTheWay.png"),
            ),
            //pick up status
            Text(
              "Pick up Status",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            pickupStatusCard(w, enabledBorder, focusedBorder, errorBorder),
            //passenger status

            const SizedBox(
              height: 20,
            ),
            Container(
              // height: 900,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(3, 5),
                      // spreadRadius: 4,
                      blurRadius: 3,
                      color: Colors.grey),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("No. of adults picked up :"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("No. Kids picked up : "),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("No. Carrybags on board :"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("No. Suitcases on board:"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text("3/4"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("3/4"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("3/4"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("3/4"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget pickupStatusCard(double w, OutlineInputBorder enabledBorder,
      OutlineInputBorder focusedBorder, OutlineInputBorder errorBorder) {
    return Container(
      // height: 900,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              offset: Offset(3, 5),
              // spreadRadius: 4,
              blurRadius: 3,
              color: Colors.grey),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Enter no. of adults :"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Enter no. Kids : "),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Enter no. Carrybags :"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Enter no. Suitcases :"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    enterQuantity(w, enabledBorder, focusedBorder, errorBorder,
                        adultTextController,
                        quantity: 4),
                    enterQuantity(w, enabledBorder, focusedBorder, errorBorder,
                        kidsTextController,
                        quantity: 4),
                    enterQuantity(w, enabledBorder, focusedBorder, errorBorder,
                        carryBagsController,
                        quantity: 6),
                    enterQuantity(w, enabledBorder, focusedBorder, errorBorder,
                        suitCaseController,
                        quantity: 4)
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget enterQuantity(
      double w,
      OutlineInputBorder enabledBorder,
      OutlineInputBorder focusedBorder,
      OutlineInputBorder errorBorder,
      TextEditingController controller,
      {required quantity}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 8),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            width: w * 0.2,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                enabledBorder: enabledBorder,
                focusedBorder: focusedBorder,
                errorBorder: errorBorder,
              ),
            ),
          ),
          Text(" /$quantity")
        ],
      ),
    );
  }
}
