import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali/yorumlar/KesriHan.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../map/map.dart';
late User loggedInuser;

class KesireHan extends StatefulWidget {
  const KesireHan({Key? key}) : super(key: key);

  @override
  _KesireHanState createState() => _KesireHanState();
}

class _KesireHanState extends State<KesireHan> with SingleTickerProviderStateMixin {


  double x = 37.233194;
  double y = 35.162650;
  String title = "KESİRİ HAN";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 4, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://lh3.googleusercontent.com/proxy/mL_EYbsSqSWz9h74826__0YeUAkhoS0YsA2ugqafo0bzJ6lpLyzjUk7pr_rFcBNmWm8HqAmEldt4STt7wzV7bhq01ToZvB4K_jncpBxL4ar-JhYw-vQh1gEBja25GwkK",
    "http://3.bp.blogspot.com/-RWc2RD1Ny08/VD-KEPdXEFI/AAAAAAAABmc/XI8Ut0-i9CQ/s1600/musttafa_yerkopru_21032010_481_2.jpg",
    "https://www.gidilmeli.com/sayfa/resim/6141fe25aa5dae5df8061e9dc237aa5c.jpg",
    "http://1.bp.blogspot.com/-TjTp_WvTbN4/VGhmMsq6xlI/AAAAAAAABvM/tB6joSbnOj0/s1600/Kesrikhan%2Byak%C4%B1ndan%2Bg%C3%B6r%C3%BCn%C3%BC%C5%9F.jpg",
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
      message: 'Kesri Han hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/karaisali/kesire/k4.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("kesriYorum")
            .doc(loggedInuser.email)
            .set({
          'email': loggedInuser.email.toString(),
          'icerik': response.comment.toString(),
          'puan': response.rating.toString()
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
      appBar: AppBar(
        backgroundColor: sinir,
        title: Center(child: Text(title)),
        actions: [
          IconButton(
            onPressed: ()
            {
              MapUtils.openMap(x, y);
            },
            icon: Icon(Icons.map_sharp,color: Colors.white,),

          ),
          IconButton(
            onPressed: () {
              _showRatingAppDialog();
            },
            icon: Icon(
              Icons.comment_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ImageSlider(
                /// Shows the tab indicating circles at the bottom
                showTabIndicator: true,

                /// Cutomize tab's colors
                tabIndicatorColor: Colors.lightBlue.shade300,

                /// Customize selected tab's colors
                tabIndicatorSelectedColor: Colors.lightBlue.shade800,

                /// Height of the indicators from the bottom
                tabIndicatorHeight: 9,

                /// Size of the tab indicator circles
                tabIndicatorSize: 9,

                /// tabController for walkthrough or other implementations
                tabController: tabController,

                /// Animation curves of sliding
                curve: Curves.fastOutSlowIn,

                /// Width of the slider
                width: MediaQuery.of(context).size.width,

                /// Height of the slider
                height: 220,

                /// If automatic sliding is required
                autoSlide: true,

                /// Time for automatic sliding
                duration: new Duration(seconds: 3),

                /// If manual sliding is required
                allowManualSlide: true,

                /// Children in slideView to slide
                children: links.map((String link) {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: scaffold,
                      border: Border.all(color: sinir, width: 2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(color: Colors.blue.shade300, spreadRadius: 1)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "İçinde yaşadığımız coğrafya insanlık tarihinin en "
                          "önemli değişimlerine tanıklık etmiş binlerce"
                          " kültür mirasına sahip bir coğrafyadır. Ancak "
                          "şu da bir gerçektir ki bu tarihi mirası olması "
                          "gerektiği biçimde koruma, kollama ve yaşatma "
                          "görevlerini bu toplum yönetenler ve bu toplumun"
                          " bireyleri yerine getirememiştir. Kentlerimiz "
                          "günlük çıkarlara feda edilmiş, pek çok eser yok "
                          "edilmiş, yakılmış, yurt dışına kaçırılmış,"
                          " müzelerimizde sergilenmeden depolarda terk "
                          "edilmiş, alınmış, satılmış, mekânlar harabe "
                          "ve mezbele durumlara düşürülmüş bazen yenileme "
                          "adı altında aslı ile ilgisi olmayan formlara "
                          "dönüştürülmüştür. Korunmaya değer görülenler "
                          "ise dönemlerinin ekonomik, sosyal ve siyasal "
                          "koşullarınca belirlenmiştir. Oyda bugün insanlık "
                          "tarihi hakkında bildiklerimizin pek çoğu yıllara"
                          " meydan okuyan bu eserler sayesinde olmuştur.",
                      style: cityIcerik,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => Maps(x: x, y: y, title: title));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Center(
                    child: Text(
                      "HARİTADA GÖSTER",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
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
                  Get.to(() => KesriHanYorum());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Center(
                    child: Text(
                      "YORUMLARI GÖSTER",
                      style: cityName2,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: sinir,
                    border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
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
