import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/pozanti/yorumlar/tabya_yorum.dart';
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

class Tabyalar extends StatefulWidget {
  const Tabyalar({Key? key}) : super(key: key);

  @override
  _TabyalarState createState() => _TabyalarState();
}

class _TabyalarState extends State<Tabyalar>
    with SingleTickerProviderStateMixin {
  double x = 37.328892;
  double y = 34.780441;
  String title = "İBRAHİM PAŞA TABYASI";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  static List<String> links = [
    "https://www.kulturportali.gov.tr/contents/images/05022013_73515f48-da81-4c97-8579-9e538443932d.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/a/a1/Casemate_of_%C4%B0brahim_Pasha%2C_Mersin_Province.jpg",
    "https://www.gezi-yorum.net/wp-content/uploads/2019/12/ibrahim-pa%C5%9Fa-tabyas%C4%B1.2.jpg",
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://www.gezi-yorum.net/wp-content/uploads/2019/12/ibrahim-pa%C5%9Fa-tabyas%C4%B1.2.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("TabyaYorum")
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
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kutu,
      appBar: mainAppBar(title),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: size.width,
                child: sliderImage(
                  context,
                  links,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              infoText("İbrahim Paşa Tabyaları oldukça sağlam ve bölgede"
                  " sayısı çok az olan Osmanlı Dönemi yapılarındandır."
                  " Yaklaşık 1830’lu yıllarda, doğudan gelecek saldırılara"
                  " karşı koymak için İbrahim Paşa tarafından "
                  "yaptırılmıştır. Tarsus Pozantı istikametinde otobanda"
                  " ilerlerken Adana’ya bağlı Tekir (Akçatekir) Yaylası "
                  "mevkisine gelmeden yolun solundaki yüksek tepe üzerinde"
                  " bir yapı görülmektedir. Bu yapı Kızıl Tabya (Büyük "
                  "veya Fenerli Tabya) olarak adlandırılmaktadır.. "
                  "Burada yer alan diğer tabyalar Yer Tabyaları , "
                  "Armutlu Tabya ve Ak (Beyaz- Küçük Tabya) Tabya‘dır. "
                  "Bunlardan Kızıl Tabya, Ak Tabya ile karşılıklı olarak "
                  "iki yüksek tepeye yapılmışlardır ve birbirlerini görmektedirler."
                  " Antik dönemden beri stratejik konumu olan bu yer bu anlamda "
                  "Gülek Kalesi ve Gülek Yazıtı ile de uyum içerisindedir. "
                  "Bu tabyalardan çıkarılan birkaç top Gülek Kasabası'na "
                  "nakledilmiştir."),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
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
                ),
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
                Get.to(() => TabyaYorum());
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
