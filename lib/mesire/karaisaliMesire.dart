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

class KaraisaliMesireList extends StatefulWidget {
  const KaraisaliMesireList({Key? key}) : super(key: key);

  @override
  _KaraisaliMesireListState createState() => _KaraisaliMesireListState();
}

class _KaraisaliMesireListState extends State<KaraisaliMesireList> {



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
                    Get.to(() => Karapinar());
                  },
                  child: sehirler("KARAPINAR PARKI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to(() => Dokuzoluk());
                  },
                  child: sehirler("DOKUZOLUK")),
              InkWell(

                onTap: ()
                  {
                    Get.to( () => YerKopru());
                  },

                  child: sehirler("YERKÖPRÜ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => AlmanKoprusu());
                  },
                  child: sehirler("ALMAN KÖPRÜSÜ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => Kanyon());
                  },
                  child: sehirler("KAPIKAYA KANYONU")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => Kizildag());
                  },
                  child: sehirler("KIZILDAĞ YAYLASI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => KesireHan());
                  },
                  child: sehirler("KESİRİ HAN")),



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
