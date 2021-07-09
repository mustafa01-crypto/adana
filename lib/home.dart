import 'package:adana/constants/constants.dart';
import 'package:adana/mesire/karaisaliMesire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => KaraisaliMesireList());
                  },
                  child: sehirler("KARAİSALI")),
              sehirler("SEYHAN"),
              sehirler("CEYHAN"),
              sehirler("POZANTI"),
              sehirler("KOZAN"),
              sehirler("FEKE"),
              sehirler("SAİMBEYLİ"),
              sehirler("TUFANBEYLİ"),
              sehirler("YUMURTALIK"),
              sehirler("KARATAŞ"),
            ],
          ),
        ),
      ),
    );
  }

  Widget sehirler(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                text,
                style: cityName,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: scaffold,
          border: Border.all(color: Colors.blueAccent.shade100, width: 4),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
