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
   // final height = MediaQuery.of(context).size.height;
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
