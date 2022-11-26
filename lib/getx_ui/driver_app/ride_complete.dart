// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RideComplete extends StatelessWidget {
  final int index;
  const RideComplete({
    Key? key,
    required this.index,
  }) : super(key: key);

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
