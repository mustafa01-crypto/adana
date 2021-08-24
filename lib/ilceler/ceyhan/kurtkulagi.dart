import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/yorumlar/kurtYorum.dart';
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

class KurtKulagi extends StatefulWidget {
  const KurtKulagi({Key? key}) : super(key: key);

  @override
  _KurtKulagiState createState() => _KurtKulagiState();
}

class _KurtKulagiState extends State<KurtKulagi>
    with SingleTickerProviderStateMixin {
  double x = 36.9235693;
  double y = 35.8837971;
  String title = "Kurtkulağı Kervansarayı";
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
   "https://i.arkeolojikhaber.com/images/2019/51/27515.jpg",
    "https://mapio.net/images-p/14857663.jpg",
    "https://foto.sondakika.com/haber/2019/12/22/osmanli-mirasi-kurtkulagi-kervansarayi-turizm-4-12742111_osd.jpg",
    "https://im.haberturk.com/2019/12/23/ver1577096633/2552202_1024x576.jpg"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://mapio.net/images-p/14857663.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("KurtYorum")
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
              infoText("Ceyhan'ın 12 km güneydoğusunda Kurtkulağı mahallesi'ndedir. "
                  "Adana Müzesinde bulunan kervansaray kitabesine göre eser "
                  "1659'da Hüseyin Paşa tarafından yaptırılmış olup, mimarı Mehmed "
                  "Ağa'dır. Adana-Halep kervan yolu üzerindeki Kurtkulağı menzilinde "
                  "bulunan kervansaray, bir Osmanlı menzil handır. Kervansaray bir kale"
                  " sağlamlığında gayet kalın ve sağlam duvarlara sahiptir. 2006 "
                  "yılında restore edilmiştir."
                  "Büyük bir dikdörtgenden oluşan planı doğu cephede klasik kervansaray"
                  " mimarisinden farklı özellikler taşımaktadır. Üç yanda "
                  "saçak hizasına kadar kuvvetli payandalarla takviye edilmiş"
                  " olan beden duvarlarının tamamı taştandır. Doğu cephedeki "
                  "çıkıntıları hariç, 45,75 x 23,60 metre ebadındaki kervansarayın "
                  "planını, enine uzanan iki sıralı payelerin birbirlerine sivri kemerlerle "
                  "birleşmesi ve bütün üst örtüyü teşkil eden boyuna uzanan beşik tonozlar"
                  " meydana getirmektedir."),
              SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_circle_up,color: Colors.black,size: 40,),                    onPressed: ()
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
                Get.to(() => Maps(), arguments:[ x,y,title]);
              },
              child: buttonTextContainer(context, "HARİTADA GÖSTER")),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => KurtYorum());
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
