import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
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

class KaratasPlaji extends StatefulWidget {
  const KaratasPlaji({Key? key}) : super(key: key);

  @override
  _KaratasPlajiState createState() => _KaratasPlajiState();
}

class _KaratasPlajiState extends State<KaratasPlaji>
    with SingleTickerProviderStateMixin {
  double x = 36.5521353;
  double y = 35.3600489;
  String title = "Karataş Plajı";
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
    "https://cdn.otelleri.net/landing/karatas/gezi-rehberi/karatas-plaji-2478-61.jpg",
    "https://cdn.otelleri.net/landing/karatas/gezi-rehberi/bahce-belediye-halk-plaji-2478-31.jpg",
    "https://seyyahdefteri.com/wp-content/uploads/2019/05/Karata%C5%9F-Plaj%C4%B1.jpg",
    "https://blog.biletbayi.com/wp-content/uploads/2018/08/karatas-adana-scaled.jpg",
    "https://www.gezi-yorum.net/wp-content/uploads/2019/12/karata%C5%9F.genel_.1.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfhl1rAZl9z6yWACxAhO-iXvjoDvMw5IAO-g&usqp=CAU"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://blog.biletbayi.com/wp-content/uploads/2018/08/karatas-adana-scaled.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("PlajYorum")
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
              infoText("Karataş Plajı Çukurova’ya yaklaşık 90 km uzaklıktadır."
                  " Türkiye’nin ve Dünya’nın en önemli ve uzun "
                  "kumsallarından biridir. Akdeniz’in ikliminden "
                  "kaynaklı yılın çoğunluğu denize girilebilmektedir."),
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
                Get.to(() => KaratasPlaji());
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
