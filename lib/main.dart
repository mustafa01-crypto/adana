// @dart=2.9
import 'package:adana/mesire/karaisaliMesire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_drawer/slide_drawer.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SlideDrawer(
        isRotate: true,
        rotateAngle: 180 / 36,
        items: [
          MenuItem('KARAİSALI',  onTap: (){
            Get.to(()=> KaraisaliMesireList());
          }),
          MenuItem('SEYHAN',  onTap: (){}),
          MenuItem('CEYHAN',  onTap: (){}),
          MenuItem('YUMURTALIK',  onTap: (){}),
          MenuItem('KOZAN',  onTap: (){}),
        ],
        brightness: Brightness.dark,
        backgroundGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: [
            Color(0xFFF2690B),
            Color(0xFFD59467),
          ],
        ),
        child: Home(),
      ),
    );
  }
}
