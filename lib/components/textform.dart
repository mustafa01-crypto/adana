import 'package:flutter/material.dart';

class TextForms extends StatefulWidget {
  String t1;
  String t2;


  TextForms({required this.t1,required this.t2});

  @override
  _TextFormsState createState() => _TextFormsState();
}

class _TextFormsState extends State<TextForms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity *4/5,
      height: 300,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,

          ),
        ]

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Email"),
          TextFormField(

          ),
          SizedBox(height: 23,),
          Text("Parola"),
          TextFormField(

          )

        ],
      ),
    );
  }
}
