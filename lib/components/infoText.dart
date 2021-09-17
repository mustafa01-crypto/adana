import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget infoText(String text){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 6.w),
    child: Container(
      decoration: BoxDecoration(
          gradient: boxGradient,
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
        padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
        child: Text(
          text,
          style: metin,
        ),
      ),
    ),
  );
}