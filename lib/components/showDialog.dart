
import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';


showMaterialDialog(
    {required String title,
      required String content,
      required BuildContext context,
      double? width,
      double? height}) {
  ;
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          Container(
            width: width,
            height: height,
            child: ElevatedButton(
              child: Text("Tamam"),
              style: ElevatedButton.styleFrom(
                primary: sinir,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ));
}
