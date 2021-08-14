import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget mainAppBar(String title){
  return AppBar(
    centerTitle: true,
    title: Text(title,style: xdAppBarBaslik,),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: xdGradient,
      ),
    ),

  );
}