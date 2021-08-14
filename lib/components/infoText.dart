import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';

Widget infoText(String text){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      decoration: BoxDecoration(
          color: xdArka,
          border: Border.all(color: xdArka, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ]

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
        child: Text(
          text,
          style: xdUzunYazi,
        ),
      ),
    ),
  );
}