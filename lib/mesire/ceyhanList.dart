import 'package:adana/components/ilceMesire.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/anavarza.dart';
import 'package:adana/ilceler/ceyhan/durhasan.dart';
import 'package:adana/ilceler/ceyhan/kurtkulagi.dart';
import 'package:adana/ilceler/ceyhan/tumlu.dart';
import 'package:adana/ilceler/ceyhan/yilanKale.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffold2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => YilanKale());
                  },
                  child: sehirYerleri(context, "YILAN KALE")),
              InkWell(
                  onTap: () {
                    Get.to(() => KurtKulagi());
                  },
                  child: sehirYerleri(context, "KURTKULAĞI KERVANSARAYI")),
              InkWell(
                  onTap: () {
                    Get.to(() => Tumlu());
                  },
                  child: sehirYerleri(context, "TUMLU KALESİ")),
              InkWell(
                  onTap: () {
                    Get.to(() => Durhasan());
                  },
                  child: sehirYerleri(context, "DURHASAN DEDE TÜRBESİ")),
              InkWell(
                  onTap: () {
                    Get.to(() => Anavarza());
                  },
                  child: sehirYerleri(context, "ANAVARZA KALESİ")),
            ],
          ),
        ),
      ),
    );
  }
}
