import 'package:adana/auth/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali/yorumlar/karapinar.dart';
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

class Karapinar extends StatefulWidget {
  const Karapinar({Key? key}) : super(key: key);

  @override
  _KaraisaliState createState() => _KaraisaliState();
}

class _KaraisaliState extends State<Karapinar>
    with SingleTickerProviderStateMixin {
  double x = 37.261862;
  double y = 35.058648;
  String title = "Karapınar Parkı";
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
    "https://media-cdn.tripadvisor.com/media/photo-s/17/df/78/b8/photo8jpg.jpg",
    "https://www.sehirlersavasi.com/ilce-resimleri/resimler/10425316KARAPINAR_PARKI.jpg",
    "https://lh3.googleusercontent.com/p/AF1QipN_rs1erCu3hHuXD_N0oxhuRKb41OiM0Npoyr1u=s1600-w400",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2lLwqNyty_GdqPiuko5kZBcMynG-7eB8KzA&usqp=CAU",
    "https://www.karaisalim.com/wp-content/uploads/2014/02/karaisali-karapinar-resimleri-48.jpg",
    "https://www.karaisalim.com/wp-content/uploads/2014/02/karaisali-karapinar-resimleri-9.jpg",
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: 'Karapınar Parkı hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/karaisali/park/k.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("karaipinarYorum")
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
              infoText("Türkiye’nin Akdeniz Bölgesinde bulunan"
                  " Karaisalı, Roma Döneminden önemli izler taşıyan"
                  " ilçe konumuna sahip olan bir bölgedir. Bu ilçe,"
                  " soyunun Ramazanoğulları ve Menemencioğullarından geldiği"
                  " günümüzdeki adını"
                  " da Ramazanoğullarından Kara İsa Bey’den aldığı bilinen bir husustur."),
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
                    Get.to(() => ParkYorum());
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
