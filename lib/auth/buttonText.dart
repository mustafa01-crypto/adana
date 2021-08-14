import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';

Widget buttonTextContainer(BuildContext context,String buttonName,){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 70,
    child: Center(
      child: Text(
        buttonName,
        style: cityName,
      ),
    ),
    decoration: BoxDecoration(
      color: xdArka,
      //border: Border.all(color: kutu, width: 4),
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.black38.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, -3), // changes position of shadow
        ),
      ],
    ),
  );
}