import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';

Widget sehirYerleri(BuildContext context,String text){
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Center(
        child: Text(
          text,
          style: cityName,
        ),
      ),
      decoration: BoxDecoration(
        color: xdArka,
        //  border: Border.all(color: scaffold, width: 4),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
    ),
  );
}