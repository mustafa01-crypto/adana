import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/pozanti/yorumlar/armut_yorum.dart';
import 'package:adana/map/map.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';

late User loggedInuser;
var now = new DateTime.now();
var formatter = new DateFormat('dd-MM-yyyy');
String formattedDate = formatter.format(now);

class ArmutYayla extends StatefulWidget {
  const ArmutYayla({Key? key}) : super(key: key);

  @override
  _ArmutYaylaState createState() => _ArmutYaylaState();
}

class _ArmutYaylaState extends State<ArmutYayla>
    with SingleTickerProviderStateMixin {
  double x = 37.521421;
  double y = 35.050081;
  String title = "Armutoğlu Yaylası";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  static List<String> links = [
    "https://www.gelgez.net/wp-content/uploads/2017/03/adanada-gidilmesi-gereken-5-yaylasi-nerededir-nasil-gidilir-armutoglu-yaylasi-fotografi-1-gelgez-728x546.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIrxiV9RuDAgF1ODRCQXrvxlir3H0_55jtOw&usqp=CAU",
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIrxiV9RuDAgF1ODRCQXrvxlir3H0_55jtOw&usqp=CAU",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("ArmutYorum")
            .doc(loggedInuser.email)
            .set({
          "zaman": formattedDate.toString(),
          'email': loggedInuser.email.toString(),
          'icerik': response.comment.toString(),
          'puan': response.rating.toDouble()
        });
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kutu,
      appBar: mainAppBar(title),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              sliderImage(
                context,
                links,
              ),
              SizedBox(
                height: 10,
              ),
              infoText(
                  "Pozantı-Ankara yol ayrımından doğuya doğru (Sarımsak Dağı)"
                      " dönülerek 13 kilometrelik çam ve köknar ormanları "
                      "içinden geçilerek ulaşılır. Tamamen bakir durumda olan"
                      " yayla sedir, köknar, ardıç ağaçları ve kır çiçekleri "
                      "ile iç içedir. Sarımsak Dağı’nın eteğinde bulunması "
                      "nedeniyle yaban hayatı bakımından da çok zengindir."
                      " Doğa ile baş başa buz gibi akan pınarların başında "
                      "çadır kurarak kamp yapmak, çevrede bulunan yaban hayatını "
                      "incelemek ve görüntülemek isteyenlerin tercih edeceği bir yayladır."),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_up,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    Get.bottomSheet(buildSheet(),
                        barrierColor: Colors.white.withOpacity(0.6),
                        isScrollControlled: false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet() {
    return Container(
      color: kutu,
      child: ListView(
        children: [
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => Maps(), arguments: [x, y, title]);
              },
              child: buttonTextContainer(context, "HARİTADA GÖSTER")),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => ArmutYorum());
              },
              child: buttonTextContainer(context, "YORUMLARI GÖSTER")),

          //xd
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                MapUtils.openMap(x, y);
              },
              child: buttonTextContainer(context, "YOL TARİFİ")),
          SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {
              _showRatingAppDialog();
            },
            child: buttonTextContainer(context, "YORUM YAP"),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel_sharp,
              size: 25,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
