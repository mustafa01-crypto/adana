import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/anavarza.dart';
import 'package:adana/ilceler/ceyhan/durhasan.dart';
import 'package:adana/ilceler/ceyhan/kurtkulagi.dart';
import 'package:adana/ilceler/ceyhan/tumlu.dart';
import 'package:adana/ilceler/ceyhan/yilanKale.dart';
import 'package:adana/ilceler/cukurova/dogalPark.dart';
import 'package:adana/ilceler/cukurova/karatasPlaji.dart';
import 'package:adana/ilceler/cukurova/muzeKompleksi.dart';
import 'package:adana/ilceler/cukurova/sevgiAdasi.dart';
import 'package:adana/ilceler/cukurova/seyhanBaraji.dart';
import 'package:adana/ilceler/cukurova/yumurtalikLagunu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CeyhanList extends StatefulWidget {
  const CeyhanList({Key? key}) : super(key: key);

  @override
  _CeyhanListState createState() => _CeyhanListState();
}

class _CeyhanListState extends State<CeyhanList> {



  @override
  Widget build(BuildContext context) {
   // final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [

              InkWell(
                  onTap: () {
                    Get.to(() => YilanKale());
                  },
                  child: sehirler("YILAN KALE")),
              InkWell(
                  onTap: ()
                  {
                    Get.to(() => KurtKulagi());
                  },
                  child: sehirler("KURTKULAĞI KERVANSARAYI")),
              InkWell(

                  onTap: ()
                  {
                    Get.to( () => Tumlu());
                  },

                  child: sehirler("TUMLU KALESİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => Durhasan());
                  },
                  child: sehirler("DURHASAN DEDE TÜRBESİ")),
              InkWell(
                  onTap: ()
                  {
                    Get.to( () => Anavarza());
                  },
                  child: sehirler("ANAVARZA KALESİ")),

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
