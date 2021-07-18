import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/saatKulesiYorum.dart';
import 'package:adana/map/map.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';
import 'package:rating_dialog/rating_dialog.dart';

late User loggedInuser;

class SaatKulesi extends StatefulWidget {
  const SaatKulesi({Key? key}) : super(key: key);

  @override
  _SaatKulesiState createState() => _SaatKulesiState();
}

class _SaatKulesiState extends State<SaatKulesi> with SingleTickerProviderStateMixin {


  double x = 36.983835;
  double y = 35.330260;
  String title = "BÜYÜK SAAT KULESİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.kulturportali.gov.tr/contents/images/20171016141538056_ADANA%20SAAT%20KULESI%20GULCAN%20ACAR%20(11).jpg",
    "https://cdn1.neredekal.com/hotel/2/reB/520x293/2NsP.jpg",
    "https://i.arkeolojikhaber.com/images/2018/29/14770.jpg",
    "https://www.nisandaadanada.com/assets/img/gorulmesi-gereken-yerler/buyuk-saat-kulesi.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQE9TGtFkCzNFur7b9UigZuInqGVjRcC3CWQ&usqp=CAU",
    "https://adabul.com/wp-content/uploads/2018/01/merdiven.jpg",
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
      message: 'Büyük Saat Kulesi hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/karaisali/SaatKulesi/y3.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("SaatKulesiYorum")
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
                      "Kule kesme taştan yapılmıştır. Uzunluğu 32 metre olan kule "
                          "kare prizma şeklindedir ve kulenin duvarları tuğla ile"
                          " inşa edilmiştir. Temel derinliğinin 35 metre olduğu "
                          "söylenir. Saat kulesi dikdörtgen şeklinde taş tuğlalardan "
                          "yapılmıştır. Kulenin inşası sırasında Osmanlı'da değişik "
                          "illerde saat kuleleri vardı. Bu saat kuleleri arasında en "
                          "uzunu Büyük Saat'tir. İkincisi ise Dolmabahçe Saat Kulesi’dir."
                          " Örme işlemi oldukça zor olan küçük taş tuğlalardan imal edilmiş "
                          "ve yapımından uzun bir süre sonra Almanya’dan özel olarak saat "
                          "makinesi getirilmiştir. O kadar sağlam yapılmıştır ki 1998’deki "
                          "Adana depreminden sonra bile ayakta kalmayı başarabilmiştir.",
                      style: cityIcerik,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: ()
                {
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
                  Get.to(() => SaatKulesiYorum());
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
