import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/pozanti/yorumlar/akca_tekir_yorum.dart';
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

class AkcaTekir extends StatefulWidget {
  const AkcaTekir({Key? key}) : super(key: key);

  @override
  _AkcaTekirState createState() => _AkcaTekirState();
}

class _AkcaTekirState extends State<AkcaTekir>
    with SingleTickerProviderStateMixin {
  double x = 37.383076;
  double y = 34.752021;
  String title = "AkçaTekir Yaylası";
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
    "https://pbs.twimg.com/media/DhUpcEKXkAAFDZL.jpg",
    "https://www.emlakdream.com/wp-content/uploads/2018/01/310120151335413322831_2.jpg",
    "https://foto.haberler.com/haber/2012/03/07/akcatekir-deki-tapu-magdurlarinin-cifte-stand-3425474_amp.jpg",
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://www.emlakdream.com/wp-content/uploads/2018/01/310120151335413322831_2.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("AkcaTekirYorum")
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
              infoText("Pozantı İlçesi'ne 17 kilometre uzaklıktaki "
                  "yayla Adana-Ankara E-90 oto yolunun 90'ıncı "
                  "kilometresinde yolun her iki yakasında çok geniş"
                  " bir alana yayılmıştır. Bürücek Yaylası, Akçaköy ve"
                  " Tekir Yaylası'nın birleşmesiyle oluşan Akçatekir "
                  "Beldesi'nin bir mahallesi konumundadır. Çam, ardıç ve"
                  " meyve bahçeleri arasında kurulmuş olan yaylada, yayla"
                  " mimarisine uygun yapıların yanında farklı mimari"
                  " tarzların örneklerini de görmek mümkündür."
                  " Her yıl 1 Eylül tarihinde "
                  "Akçatekir Yaylası Geleneksel Yayla Şenlikleri yapılmaktadır."),
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
                Get.to(() => AkcaTekirYorum());
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
