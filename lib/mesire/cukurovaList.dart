import 'package:adana/components/ilceMesire.dart';
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
   // final height = MediaQuery.of(context).size.height;
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
                  child: sehirYerleri(context,"SEVGİ ADASI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to(() => SeyhanBaraji());
                  },
                  child: sehirYerleri(context,"SEYHAN BARAJI GÖLÜ")),
              InkWell(

                  onTap: ()
                  {
                    Get.to( () => MuzeKompleksi());
                  },

                  child: sehirYerleri(context,"ADANA MÜZE KOMPLEKSİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => DogalPark());
                  },
                  child: sehirYerleri(context,"ÇUKUROVA DOĞAL PARK")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => YumurtalikLagunu());
                  },
                  child: sehirYerleri(context,"YUMURTALIK LAGÜNÜ MİLLİ PARKI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => KaratasPlaji());
                  },
                  child: sehirYerleri(context,"KARATAŞ PLAJI")),

            ],
          ),
        ),
      ),
    );
  }


}
