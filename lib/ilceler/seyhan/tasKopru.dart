import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/taskopruYorum.dart';
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

class TasKopru extends StatefulWidget {
  const TasKopru({Key? key}) : super(key: key);

  @override
  _TasKopruState createState() => _TasKopruState();
}

class _TasKopruState extends State<TasKopru>
    with SingleTickerProviderStateMixin {
  double x = 36.986300;
  double y = 35.334989;
  String title = "TAŞ KÖPRÜ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://seyyahdefteri.com/wp-content/uploads/2018/12/Adana-Ta%C5%9F-K%C3%B6pr%C3%BC-2.jpg",
    "https://www.altinrota.org/assets/images/uploads/articles/global/2019-03-20-151341-taskopru-ve-hilton.JPG",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR26F6xcS1JrHM8ycynEzCA6oQASoYTpaEY3Q&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsIPoSYU_kGkVmie6W4CqGeY8L0xMuBTK3Rg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNOUio5hmUUY8J81yGL-dvyKfWguc_Kub0WA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsX5JkZN6SH88tk2DusnOEFLP6xZr_P6NKxA&usqp=CAU",
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
      message: 'Yerköprü hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/taskopru.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("TasKopruYorum")
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
      appBar: mainAppBar("YORUMLAR"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              sliderImage(
                tabController!,
                context,
                links.map((String link) {
                  return new ClipRRect(
                      child: Image.network(
                    link,
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    fit: BoxFit.fill,
                  ));
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              infoText(
                  "Adana Taş Köprü Seyhan Nehri üzerindedir. IV. (385) yüzyılda "
                  "Roma İmparatoru Hadrianus tarafından yaptırılmıştır."
                  " Yüzyıllarca Avrupa ile Asya arasında önemli bir köprü "
                  "olmuştur. Harun Reşit (766-809) köprüyü bazı eklerle"
                  " Adana Kalesi'ne birleştirmiştir. IX. yüzyıl başında"
                  "Harun Reşit’in oğlu olan 7'inci Abbasi Halifesi Memun "
                  "(786-833) tarafından onartılmıştır. III. Ahmet (1713),"
                  " Kel Hasan Paşa (1847) ve Adana Valisi Ziya Paşa (1789) "
                  "tarafından da değişik zamanlarda tamirat görmüştür."
                  " Bu üç onarımının yazıtları mevcuttur. Son onarım"
                  " 1949 yılında yapılmıştır."
                  "Taş Köprü 319 metre uzunluğunda ve 13 metre "
                  "yüksekliğindedir. 21 kemerinden 14’ü ayaktadır."
                  " Ortadaki büyük kemerde iki aslan kabartması "
                  "görülmektedir. Dünyanın halen kullanılan en "
                  "eski köprülerden biri olarak bilinmektedir."),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.grey,
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
                Get.to(() => Maps(
                      x: x,
                      y: y,
                      title: title,
                    ));
              },
              child: buttonTextContainer(context, "HARİTADA GÖSTER")),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => TasKopruYorum());
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
