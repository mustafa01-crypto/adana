import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


toastMessage() {
  return Fluttertoast.showToast(
      msg: "Yorumunuz başarıyla silindi",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}