import 'package:adana/components/infoText.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/merkezCamiYorum.dart';
import 'package:adana/map/map.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';

late User loggedInuser;
var now = new DateTime.now();
var formatter = new DateFormat('dd-MM-yyyy');
String formattedDate = formatter.format(now);

class SabanciMerkezCamii extends StatefulWidget {
  const SabanciMerkezCamii({Key? key}) : super(key: key);

  @override
  _SabanciMerkezCamiiState createState() => _SabanciMerkezCamiiState();
}

class _SabanciMerkezCamiiState extends State<SabanciMerkezCamii>
    with SingleTickerProviderStateMixin {
  double x = 36.991574;
  double y = 35.334198;
  String title = "SABANCI MERKEZ CAMİİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.kulturportali.gov.tr/contents/images/27032013_98c02bba-053a-4301-9d97-2670551dda99.jpg",
    "https://mapio.net/images-p/63237478.jpg",
    "https://www.camilerveturbeler.com/wp-content/uploads/2014/04/sabanci5.jpg",
    "https://www.kulturportali.gov.tr/repoKulturPortali/DokumanlarGorseller/ADANASABANCIMERKEZCAMIIATILLAANDIRIN315_20160418141038768_20170224155120527.jpg?format=jpg&quality=50",
    "https://i.pinimg.com/originals/ff/77/88/ff77883c48254f049c6d83c55c22bdec.jpg",
    "https://2.bp.blogspot.com/-52p9TfyICpI/WEq-iokllaI/AAAAAAAABHU/SkMrxfukIw0XPXE6djcyuwDpGcSQ87eaACLcB/s1600/adana.jpg",
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
      message: 'Sabancı Merkez Camii hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/merkezcami.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("MerkezCamiYorum")
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
      appBar: AppBar(
      //  backgroundColor: sinir,
        centerTitle: true,
        title: Text(title,style: xdAppBarBaslik,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: xdGradient,
          ),
        ),
      ),
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
              infoText("Adana'nın Reşatbey Semti'nde, Merkez Park'ın güneyinde ve Seyhan "
                  "Nehri'nin batı kıyısında yer alan cami, 1998 yılında hizmete "
                  "açılmıştır. 32 metre çaplı ana kubbesi vardır. Caminin proje "
                  "mimarı Necip Dinç’tir. 20 bin kişilik cami (açık alanın düzenlenmesiyle"
                  " 28 bin kişi) son cemaat mahaliyle birlikte 6 bin 600 metrekareye yayılmıştır."
                  " Klasik Osmanlı mimarisi tarzında yapılmıştır ve dokuz fil ayağı üzerine"
                  " oturur. Genel görünüm olarak Sultan Ahmet Camii’ne, plan ve iç mekân "
                  "olarak Selimiye Camii’ne benzer. Dört yarım-kubbe, beş kubbe, altı "
                  "minaresi vardır; bunlar dört halife ve dört mezhebe, İslam’ın beş "
                  "şartına, imanın altı şartına karşılık gelmektedir. 32 metre çaplı "
                  "ana kubbe 32 farza, avludaki 28 kubbe Kuran-ı Kerim'de adı geçen"
                  " 28 peygambere, ana kubbedeki 40 pencere Hz.Muhammed (s.a.v.)’in "
                  "peygamber olduğu yaşa ve 40 rekat namaza, 99 metrelik 6 minare "
                  "Allah’ın 99 güzel ismine karşılık gelir."),
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "HARİTADA GÖSTER",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //border: Border.all(color: kutu, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => MerkezCamiYorum());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "YORUMLARI GÖSTER",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //  border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
              ),

              //xd
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  MapUtils.openMap(x, y);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "YOL TARİFİ",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //border: Border.all(color: kutu, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  _showRatingAppDialog();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "YORUM YAP",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //  border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
