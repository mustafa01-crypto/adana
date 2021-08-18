import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/cukurova/yorumlar/lagun.dart';
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

class YumurtalikLagunu extends StatefulWidget {
  const YumurtalikLagunu({Key? key}) : super(key: key);

  @override
  _YumurtalikLagunuState createState() => _YumurtalikLagunuState();
}

class _YumurtalikLagunuState extends State<YumurtalikLagunu>
    with SingleTickerProviderStateMixin {
  double x = 36.6937859;
  double y = 35.5516076;
  String title = "Yumurtalık Lagünü";
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
    "https://dogadakiler.com/img/A/2020/11/6362529.jpg",
    "https://adabul.com/wp-content/uploads/2016/03/havadan-adana-3.jpg",
    "https://lh3.googleusercontent.com/proxy/y9-7Vx1iOHqaiRdvImOqNmnAlnCFW8qtDiTlYarvAyvtYtHtR_SYTO0rndmvIPok7sotz3YgPJLndjZfWr9fb8GfzQh7vZgQfd7B_Li7HdmiZTM",
    "https://lh3.googleusercontent.com/proxy/39RP4V8sjXq9-JpVJhAzhZvb9DDnebl3tpPVg6q1qc24MO1K6DwKumLCiv07-_71smPnwsI76y4dl2aqqVXwhJ8pUSeSNiFnfh4lE73mULK6136ke7Z5ABMkNbD3cNxZmrBWr0XfV-dUL-Tmfi2fqNYcl1MxnkIQ0JDxhExW"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://dogadakiler.com/img/A/2020/11/6362529.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("LagunYorum")
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
              infoText("Yumurtalık Lagünü Milli Parkı Çukurova’ya yaklaşık 40 km"
                  " uzaklıktadır. Birçok kuş türüne ev sahipliği yapan ve"
                  " onların göç yolu üzerinde bulunan özel bir yerdir."
                  " Kuş gözlemi yapmak isteyenlerin oldukça ilgisini çekmektedir."),
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
                Get.to(() => Maps(), arguments:[ x,y,title]);
              },
              child: buttonTextContainer(context, "HARİTADA GÖSTER")),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => LagunYorum());
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
