import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/yumurta/yorumlar/ayas_yorum.dart';
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

class AyasAntik extends StatefulWidget {
  const AyasAntik({Key? key}) : super(key: key);

  @override
  _AyasAntikState createState() => _AyasAntikState();
}

class _AyasAntikState extends State<AyasAntik>
    with SingleTickerProviderStateMixin {
  double x = 36.767102;
  double y = 35.791939;
  String title = "AYAS ANTİK KENTİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  static List<String> links = [
    "https://lh3.googleusercontent.com/proxy/jiD25VifVp5tj_rCHoSp_HIeFlOU3T4QzWjVowix0z98FVX4VSv1LjiKU6oimdThaWHY--PvwVsQSYV0eb9zZY9gz0d3GdajD9JARn_yBxNc3c6vpweDO2cfoQpkc4A",
    "https://gezimanya.com/sites/default/files/styles/800x600_/public/gezilecek-yerler/2019-12/120050296.jpg",
    "https://i.pinimg.com/736x/ee/11/6a/ee116a3fbcf6d6bc3bb128f4fd50a4b2--adana-ancient-city.jpg",
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/28032013/fcd1e073-ef3c-434a-9dff-364a7ff289e6.jpg?format=jpg&quality=50"
  ];

  void getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: 'Atatürk Evi hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/seyhan/ata.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("AyasAntikYorum")
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
                "Antik Kilikya’nın önemli liman kenti olan Aegeae M.Ö. 1'inci"
                " yüzyılda en parlak dönemini yaşamıştır. Kentin ayakta "
                "kalan eserleri, Ayas Kalesi, Süleymaniye Kulesi ve Marko "
                "Polo İskelesi’dir. Asklepieion adı verilen Helenistik "
                "Dönem'e ait olan ayrıca hastane ve tapınak kalıntılarıyla "
                "da ünlü olan kenti, Marko Polo doğuya yaptığı geziler "
                "sırasında iki kez ziyaret etmiştir. ",
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
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
                  )
                ],
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
                Get.to(() => AyasAntikYorum());
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
