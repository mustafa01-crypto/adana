import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Rives extends StatelessWidget {
  const Rives({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height* 1/3,
      decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ]
      ),
      child: RiveAnimation.asset("assets/riv/hourglass.riv"),
    );
  }
}
