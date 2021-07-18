import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';



Widget rives(BuildContext context,String yol) {
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
    child: RiveAnimation.asset(yol),
  );
}
