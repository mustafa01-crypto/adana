import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/cukurova/dogalPark.dart';
import 'package:adana/ilceler/cukurova/karatasPlaji.dart';
import 'package:adana/ilceler/cukurova/muzeKompleksi.dart';
import 'package:adana/ilceler/cukurova/sevgiAdasi.dart';
import 'package:adana/ilceler/cukurova/seyhanBaraji.dart';
import 'package:adana/ilceler/cukurova/yumurtalikLagunu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CukurovaList extends StatefulWidget {
  const CukurovaList({Key? key}) : super(key: key);

  @override
  _CukurovaListState createState() => _CukurovaListState();
}

class _CukurovaListState extends State<CukurovaList> {



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffold2,
        body: SingleChildScrollView(
          child: Column(
            children: [

              InkWell(
                  onTap: () {
                    Get.to(() => SevgiAdasi());
                  },
                  child: sehirler("SEVGİ ADASI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to(() => SeyhanBaraji());
                  },
                  child: sehirler("SEYHAN BARAJI GÖLÜ")),
              InkWell(

                  onTap: ()
                  {
                    Get.to( () => MuzeKompleksi());
                  },

                  child: sehirler("ADANA MÜZE KOMPLEKSİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => DogalPark());
                  },
                  child: sehirler("ÇUKUROVA DOĞAL PARK")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => YumurtalikLagunu());
                  },
                  child: sehirler("YUMURTALIK LAGÜNÜ MİLLİ PARKI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => KaratasPlaji());
                  },
                  child: sehirler("KARATAŞ PLAJI")),

            ],
          ),
        ),
      ),
    );
  }

  Widget sehirler(String text) {
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
}
