import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
Widget buttonBox(BuildContext context,String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    child: Center(
      child: Text(
          title,
          style: loginButton
      ),
    ),
    decoration: BoxDecoration(

      gradient: buttonBoxGradient,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.black38.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset:
          Offset(0, -1), // changes position of shadow
        ),
      ],
    ),
  );
}