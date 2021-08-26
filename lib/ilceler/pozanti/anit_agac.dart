import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/pozanti/yorumlar/anit_yorum.dart';
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

class AnitAgaci extends StatefulWidget {
  const AnitAgaci({Key? key}) : super(key: key);

  @override
  _AnitAgaciState createState() => _AnitAgaciState();
}

class _AnitAgaciState extends State<AnitAgaci>
    with SingleTickerProviderStateMixin {
  double x = 37.345413;
  double y = 34.912516;
  String title = "ANIT AĞAÇLARI";
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
    "https://cdn.otelleri.net/landing/pozanti/gezi-rehberi/pozanti-anit-agaclar-2485-e5.jpg",
    "https://webdosya.csb.gov.tr/db/turkce/dergimakaleleri/anit-agaclar-20170923154135.jpg",
    "https://mapio.net/images-p/8378469.jpg"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://mapio.net/images-p/8378469.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("AnitYorum")
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
              infoText("Pozantı ilçesi sınırlarında 3 adet ağaç mevcuttur."
                  " Bunlar Çetinlik Dağı orman arazisi içinde "
                  "bulunan Sedir ağacı, Belemedik köyünde "
                  "bulunan Çınar Ağacı ve Bürücek Yaylasında bulunan"
                  " Ceviz Ağacıdır. Kurulumuzun 22.10.2004 gün ve "
                  "200 sayılı kararı ile tescil edilen Sedir "
                  "Ağacının 635 yaşında , kurulumuzun 26.11.2004 "
                  "gün ve 245 sayılı kararı ile tescil edilen"
                  " Çınar ağacının 200 yaşında, kurulun 27.01.2005 "
                  "gün ve 331 sayılı kararı ile tescil edilen Ceviz "
                  "Ağacının 380 yaşında olduğu tahmin edilmektedir."),
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
                Get.to(() => AnitYorum());
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
