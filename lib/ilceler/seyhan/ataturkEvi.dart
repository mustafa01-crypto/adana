import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/ataturkYorum.dart';
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

class AtaturkEvi extends StatefulWidget {
  const AtaturkEvi({Key? key}) : super(key: key);

  @override
  _AtaturkEviState createState() => _AtaturkEviState();
}

class _AtaturkEviState extends State<AtaturkEvi>
    with SingleTickerProviderStateMixin {
  double x = 36.988621;
  double y = 35.331884;
  String title = "ATATÜRK EVİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20190726160159325_Ataturk%20Evi%20Muzesi%202.png?format=jpg&quality=50",
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20190726160215123_Ataturk%20Evi%20Muzesi%203.png?format=jpg&quality=50",
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20190726160046948_Ataturk%20Evi%20Muzesi.png?format=jpg&quality=50",
    "https://gezginsitesi.com/wp-content/uploads/2019/11/Adana-Atat%C3%BCrk-Evi-odalar%C4%B1.jpg",
    "https://gezginsitesi.com/wp-content/uploads/2019/11/Adana-Atat%C3%BCrk-Evi-silahlar.jpg",
    "https://gezginsitesi.com/wp-content/uploads/2019/11/adana-%C3%A7ukurova-kurtulu%C5%9F-sava%C5%9F%C4%B1-kahramanlar%C4%B1.jpg",
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
        "assets/ata.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("AtaturkEviYorum")
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
                  "Adana Atatürk Evi Müzesi, Adana Seyhan Caddesi üzerinde bulunan müze."
                  " 15 Mart 1923 tarihinde Mustafa Kemal Atatürk ve eşi Adana'yı ziyaret "
                  "ettiğinde bu binada konaklamıştır. Bina daha önceleri Ramazanoğulları"
                  " ailesine mensup Suphi Paşa'ya aitti. Bina sonraları Atatürk Bilim "
                  "ve Kültür Müzesi Koruma ve Yaşatma Derneği'nce kamulaştırılmış ve "
                  "restore edilmiştir. 1981 yılında, Atatürk'ün 100. doğum yılı dolayısıyla, "
                  "Müze Müdürlüğü'ne bağlı bir müze olarak açılmıştır. Her 15 Mart'ta "
                  "Mustafa Kemal Atatürk'ün Adana'ya gelişi resmi töreni bu müzede "
                  "tertiplenir.Müzede Atatürk'ün Adana seyahati ile ilgili fotoğrafları, "
                  "bilgiler ve belgelerle birlikte, etnografik eserler de sergilenmektedir."),
              SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_drop_up,color: Colors.grey,size: 40,),
                    onPressed: ()
                    {
                      Get.bottomSheet(
                          buildSheet(),
                          barrierColor: Colors.white.withOpacity(0.6),
                          isScrollControlled: false

                      );
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
  Widget buildSheet()
  {
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
                Get.to(() => AtaturkYorum());
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
            icon: Icon(Icons.cancel_sharp,size: 25,color: Colors.grey,),
            onPressed: ()
            {
              Get.back();
            },

          )
        ],
      ),
    );
  }

}