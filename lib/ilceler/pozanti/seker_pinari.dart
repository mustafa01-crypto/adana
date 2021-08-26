import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/pozanti/yorumlar/seker_pinari_yorum.dart';
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

class SkerPinari extends StatefulWidget {
  const SkerPinari({Key? key}) : super(key: key);

  @override
  _SkerPinariState createState() => _SkerPinariState();
}

class _SkerPinariState extends State<SkerPinari>
    with SingleTickerProviderStateMixin {
  double x = 37.472056;
  double y = 34.861610;
  String title = "ŞEKER PINARI";
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
    "https://media-cdn.tripadvisor.com/media/photo-s/16/c6/3e/8a/images-4-largejpg.jpg",
    "https://fastly.4sqi.net/img/general/200x200/46901571_E8k0HhWW5DUqs4-cEyvZ42N7YyCQe1ILxTSXWnv4ECM.jpg",
    "https://mapio.net/images-p/17101430.jpg",
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://mapio.net/images-p/17101430.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("SekerPinariYorum")
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
              infoText("Şekerpınarı, Çakıt Çayının önemli bir kısmını"
                  " oluşturan güçlü bir su kaynağıdır."
                  " Dağın içinden çağlayarak çıkan kocaman "
                  "nehir; sesiyle, görüntüsüyle ve serin "
                  "esintisiyle ziyaretçileri büyülemektedir."
                  " Şekerpınarı’nın kaynağının hemen yakınında "
                  "çeşitli firmalara ait hazır su dolum tesisleri"
                  " bulunmaktadır. Su kaynağının etrafında bulunan "
                  "ve etinin lezzetiyle ülke çapında ün kazanmış "
                  "restoranlar yemek molasını burada vermek için "
                  "iyi bir nedendir. Yine dinlenme tesislerinde "
                  "bölgenin meşhur halka tatlı, taş kadayıf gibi "
                  "tatlılarının sıcak ve taze olarak satıldığı "
                  "işletmeler de çokça tercih edilmektedir."
                  " Şekerpınarı’nın hemen aşağısında Şapkalının "
                  "Köprüsü olarak bilinen asma köprüyü geçerken "
                  "ırmağı ve üzerindeki Akköprü’yü fotoğraflamanızı,"
                  " köprüden geçince karşıda bulunan oluktan "
                  "su içmenizi tavsiye ediyoruz."),
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
                Get.to(() => SekerPinariYorum());
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
