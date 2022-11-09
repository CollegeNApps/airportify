import 'package:flutter/material.dart';

class RideComplete extends StatelessWidget {
  const RideComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/RideComplete.png"),
          Text(
            "Ride Complete",
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30),
          )
        ],
      ),
    ));
  }
}
