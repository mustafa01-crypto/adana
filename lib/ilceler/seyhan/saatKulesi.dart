import 'package:adana/auth/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/saatKulesiYorum.dart';
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

class SaatKulesi extends StatefulWidget {
  const SaatKulesi({Key? key}) : super(key: key);

  @override
  _SaatKulesiState createState() => _SaatKulesiState();
}

class _SaatKulesiState extends State<SaatKulesi>
    with SingleTickerProviderStateMixin {
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
        "assets/saat.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("SaatKulesiYorum")
            .doc(loggedInuser.email)
            .set({
          "zaman" : formattedDate.toString(),
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
       // backgroundColor: sinir,
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
              infoText("Kule kesme taştan yapılmıştır. Uzunluğu 32 metre olan kule "
                  "kare prizma şeklindedir ve kulenin duvarları tuğla ile"
                  " inşa edilmiştir. Temel derinliğinin 35 metre olduğu "
                  "söylenir. Saat kulesi dikdörtgen şeklinde taş tuğlalardan "
                  "yapılmıştır. Kulenin inşası sırasında Osmanlı'da değişik "
                  "illerde saat kuleleri vardı. Bu saat kuleleri arasında en "
                  "uzunu Büyük Saat'tir. İkincisi ise Dolmabahçe Saat Kulesi’dir."
                  " Örme işlemi oldukça zor olan küçük taş tuğlalardan imal edilmiş "
                  "ve yapımından uzun bir süre sonra Almanya’dan özel olarak saat "
                  "makinesi getirilmiştir. O kadar sağlam yapılmıştır ki 1998’deki "
                  "Adana depreminden sonra bile ayakta kalmayı başarabilmiştir."),
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
                    Get.to(() => SaatKulesiYorum());
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
                  child: buttonTextContainer(context,"HARİTADA GÖSTER")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
