import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';



Widget rives(BuildContext context,String yol) {
  final width = MediaQuery.of(context).size.width;
  return Container(
    height: width* 1/2,
    decoration: BoxDecoration(

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
