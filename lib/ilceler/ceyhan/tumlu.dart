import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/yorumlar/tumluYorum.dart';
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

class Tumlu extends StatefulWidget {
  const Tumlu({Key? key}) : super(key: key);

  @override
  _TumluState createState() => _TumluState();
}

class _TumluState extends State<Tumlu>
    with SingleTickerProviderStateMixin {
  double x = 37.1504089;
  double y = 35.7005395;
  String title = "Tumlu Kalesi";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 4, vsync: this);
  }

  void getCurrentUser() {

    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  TabController? tabController;

  static List<String> links = [
    "https://i.ytimg.com/vi/j7X7jPTfIjc/maxresdefault.jpg",
    "https://fastly.4sqi.net/img/general/200x200/134963895_uK3ormhfylwva4IG_I2Kd_pDksY7GVvgsbh186Q89uc.jpg",
    "https://www.kulturportali.gov.tr/repoKulturPortali/small/07052015/ff8bbd7b-f76a-4a58-bb8e-901349301168.jpg?format=jpg&quality=50",
    "https://lh3.googleusercontent.com/proxy/sGZOhnVX2RWye5gkxN-k4dZ_FUweHMAl24K7hal3IE5dYWvIAc6fkDlPFDZU5-S2viRNGLlTOT_n8iql3q5DaPLlnxvBOsRbH77IohYlIR335sE38f7Eww"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://i.ytimg.com/vi/j7X7jPTfIjc/maxresdefault.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("TumluYorum")
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
              sliderImage(tabController!, context, links.map((String link) {
                return new ClipRRect(
                    child: Image.network(
                      link,
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      fit: BoxFit.fill,
                    ));
              }).toList(),),

              SizedBox(
                height: 10,
              ),
              infoText("Ceyhan'ın 17 km kuzeybatısında Sağkaya bucağının Dumlu (Tumlu) "
                  "mahallesinin batısında ve 75 m kadar yükseklikteki sert kalkerli"
                  " bir tepe üzerindedir. 12. yüzyılda yapıldığı sanılmaktadır."
                  " Çevresi 800 metredir. Sekiz burçludur. Ovaya bakan doğu köşesinde "
                  "gözetleme kulesi bulunmaktadır. Tek kapısı doğuya bakmaktadır. "
                  "Kale içerisinde yapı kalıntıları ve sarnıçlar yer almaktadır."
                  " Tepe etrafında kaya mezarları görülmektedir."
                  "Kalenin kuzeyinde yarım haç şeklinde birçok mezar vardır. Bu mezarlar"
                  " genelde küçük el yapımı mağaralar biçimindedir. Kuzeybatısında "
                  "mozaikler bulunan kalede yakın zamanda bir mağara mezar ve bir toplu"
                  " mezar ortaya çıkmıştır."),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => Maps(
                    x: x,
                    y: y,
                    title: title,
                  ));
                },
                child: buttonTextContainer(context,"HARİTADA GÖSTER")
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => TumluYorum());
                },
                child: buttonTextContainer(context,"YORUMLARI GÖSTER")
              ),

              //xd
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  MapUtils.openMap(x, y);
                },
                child: buttonTextContainer(context,"YOL TARİFİ")
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  _showRatingAppDialog();
                },
                child: buttonTextContainer(context,"YORUM YAP")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
