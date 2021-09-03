import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';

InputDecoration formDecoration(
    String hintText, String label, Widget prefix, Widget suffix) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: kutu),
    labelText: label,
    labelStyle: TextStyle(color: kutu),
    fillColor: kutu,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: kutu,
        style: BorderStyle.solid,
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: kutu,
        style: BorderStyle.solid,
        width: 1.5,
      ),
    ),
    prefixIcon: prefix,
    suffixIcon: suffix,
  );
}
