import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali/almankoprusu.dart';
import 'package:adana/ilceler/karaisali/dokuzoluk.dart';
import 'package:adana/ilceler/karaisali/kanyon.dart';
import 'package:adana/ilceler/karaisali/karapinar.dart';
import 'package:adana/ilceler/karaisali/kesireHan.dart';
import 'package:adana/ilceler/karaisali/kizildagYaylasi.dart';
import 'package:adana/ilceler/karaisali/yerkopru.dart';
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
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [

              InkWell(
                  onTap: () {
                    Get.to(() => Karapinar());
                  },
                  child: sehirler("SEVGİ ADASI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to(() => Dokuzoluk());
                  },
                  child: sehirler("SEYHAN BARAJI GÖLÜ")),
              InkWell(

                  onTap: ()
                  {
                    Get.to( () => YerKopru());
                  },

                  child: sehirler("ADANA MÜZE KOMPLEKSİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => AlmanKoprusu());
                  },
                  child: sehirler("ÇUKUROVA DOĞAL PARK")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => Kanyon());
                  },
                  child: sehirler("YUMURTALIK LAGÜNÜ MİLLİ PARKI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => Kizildag());
                  },
                  child: sehirler("KARATAŞ PLAJI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => KesireHan());
                  },
                  child: sehirler("MİSİS  ÖREN YERİ")),



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
          color: Colors.white,
          border: Border.all(color: scaffold, width: 4),
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
