import 'package:adana/auth/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/cukurova/yorumlar/muze.dart';
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

class MuzeKompleksi extends StatefulWidget {
  const MuzeKompleksi({Key? key}) : super(key: key);

  @override
  _MuzeKompleksiState createState() => _MuzeKompleksiState();
}

class _MuzeKompleksiState extends State<MuzeKompleksi>
    with SingleTickerProviderStateMixin {
  double x = 36.9951108;
  double y = 35.3114389;
  String title = "Adana Müze Kompleksi";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  void getCurrentUser() {

    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  TabController? tabController;

  static List<String> links = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL2SZsXeMHUwlr6j4fzn_sTM3CbdLVMjH4Qw&usqp=CAU",
    "https://i.dha.com.tr/15648/imgs/191120181045489063498.jpg",
    "https://arkeofili.com/wp-content/uploads/2017/05/adana2.jpg",
    "https://media-cdn.tripadvisor.com/media/photo-s/05/20/62/74/adana-arkeoloji-muzesi.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0mfhVnx-iw5fqr4uEhHCzyGwe9UxDz-Ocqw&usqp=CAU",
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20190724104356353_Adana%20Muze%20Kompleksi%20(1).png?format=jpg&quality=50",
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '${title} hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://arkeofili.com/wp-content/uploads/2017/05/adana2.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("MuzeYorum")
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
        centerTitle: true,
        // backgroundColor: sinir,
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
              infoText("Adana’nın birçok farklı noktasında yapılan kazı çalışmaları ile"
                  " ortaya çıkan tarihi eserleri tek bir noktada sergilemeyi"
                  " amaçlayan ve eski bir fabrika restore edilerek yapılan"
                  " geniş müze kompleksi 2017 yılında açılmıştır. "
                  "Çukurova içerisinde yer alan bu komplekste birbirinden "
                  "farklı bölümler bulunmaktadır. Özellikle arkeolojik "
                  "müzenin çok dikkat çeken parçalara ev sahipliğini üstlendiği"
                  " rahatlıkla fark edilmektedir. Tam olarak tamamlandığında "
                  "ise kültürel ve sanatsal alanlarla konukları bambaşka bir dünya karşılayacaktır."),
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
                  Get.to(() => MuzeYorum());
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
