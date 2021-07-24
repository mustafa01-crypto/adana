import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/ataturkEvi.dart';
import 'package:adana/ilceler/seyhan/bebekliKilisesi.dart';
import 'package:adana/ilceler/seyhan/cobanDedeParki.dart';
import 'package:adana/ilceler/seyhan/saatKulesi.dart';
import 'package:adana/ilceler/seyhan/sabanciMerkezCami.dart';
import 'package:adana/ilceler/seyhan/sinemaM%C3%BCzesi.dart';
import 'package:adana/ilceler/seyhan/tasKopru.dart';
import 'package:adana/ilceler/seyhan/uluCami.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeyhanList extends StatefulWidget {
  const SeyhanList({Key? key}) : super(key: key);

  @override
  _SeyhanListState createState() => _SeyhanListState();
}

class _SeyhanListState extends State<SeyhanList> {



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffold2,
        body: SingleChildScrollView(
          child: Column(
            children: [

              InkWell(
                  onTap: () {
                    Get.to(() => TasKopru());
                  },
                  child: sehirler("TAŞ KÖPRÜ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to(() => SabanciMerkezCamii());
                  },
                  child: sehirler("SABANCI MERKEZ CAMİ")),
              InkWell(

                  onTap: ()
                  {
                    Get.to( () => UluCamii());
                  },

                  child: sehirler("ADANA ULU CAMİİ")),

              InkWell(
                  onTap: ()
                  {
                    Get.to( () => CobanDede());
                  },
                  child: sehirler("ÇOBAN DEDE PARKI")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => SaatKulesi());
                  },
                  child: sehirler("BÜYÜK SAAT KULESİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => BebekliKilisesi());
                  },
                  child: sehirler("BEBEKLİ KİLİSESİ")),

              InkWell(
                  onTap: ()
                  {
                    Get.to( () => SinemaMuzesi());
                  },
                  child: sehirler("ADANA SİNEMA MÜZESİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => AtaturkEvi());
                  },
                  child: sehirler("ATATÜRK EVİ VE MÜZESİ")),



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
