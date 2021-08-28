import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/yumurta/yorumlar/kiz_kalesi_yorum.dart';
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

class KizKalesi extends StatefulWidget {
  const KizKalesi({Key? key}) : super(key: key);

  @override
  _KizKalesiState createState() => _KizKalesiState();
}

class _KizKalesiState extends State<KizKalesi>
    with SingleTickerProviderStateMixin {
  double x = 36.767102;
  double y = 35.791939;
  String title = "KIZ KALESİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  static List<String> links = [
    "https://mapio.net/images-p/15339916.jpg",
    "https://www.sosyalsanat.net/wp-content/uploads/2015/08/IMG_3424-Yumurtal%C4%B1k-Adana.jpg",
    "https://www.sombahar.com/wp-content/uploads/2015/07/denix2.jpg"
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
            .collection("KizKalesiYorum")
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
                "Yumurtalık ilçesinin kuruluşu ilçe merkezi İskenderun "
                "Körfezinin kuzeyinde M.Ö. 4. Yüzyılın son çeyreğinde "
                "Büyük İskender’in Pers İmparatoru Dara’yı bugünkü İskenderun"
                " ile Dörtyol arasında kalan ovada mağlup etmesinden sonra "
                "İskenderin halefleri olan Makedonyalı komutanlar tarafından "
                "bir liman şehri olarak kurulmuştur. Kente eski Yunanca’da keçi "
                "anlamına gelen Aıks sözcüğünden türetilmiş Aigeai adının verilmesinin"
                " sebebi ise Büyük İskender’in Dara’dan bu bölgeyi aldığı savaşta Pers "
                "ordularının üzerlerine yürürken keçilerin boynuzlarına bağladığı"
                " meşalelerle büyük bir ordunun saldırdığı izlenimini vererek Persleri"
                " burdan kaçırması sonucu olduğu bir efsane olarak İskender dönemindeki "
                "tarih yazarlarınca anlatılmaktadır.",
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
                Get.to(() => KizKalesiYorum());
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
