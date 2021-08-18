import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/yorumlar/DurHasan.dart';
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

class Durhasan extends StatefulWidget {
  const Durhasan({Key? key}) : super(key: key);

  @override
  _DurhasanState createState() => _DurhasanState();
}

class _DurhasanState extends State<Durhasan>
    with SingleTickerProviderStateMixin {
  double x = 36.882175;
  double y = 35.736562;
  String title = "Dur Hasan Dede Türbesi";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 3, vsync: this);
  }

  void getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  TabController? tabController;

  static List<String> links = [
    "https://i.ytimg.com/vi/8WdGt7jBbDc/maxresdefault.jpg",
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/12052015/d2b528e5-7bd1-4290-a80d-6f9172600893.jpg?format=jpg&quality=50",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3kQrQLUvbvu8OtnSZncdkIGIBF1JhVfgIHxLV_yngGXx0ad4OWsH38DYlfDHDIAJ3lx0&usqp=CAU"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '${title} hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://i.ytimg.com/vi/8WdGt7jBbDc/maxresdefault.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("DurHasanYorum")
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
                  "Ceyhan ilçesinin Durhasan köyü girişinde sağ tarafta bir tepenin"
                  " üzerinde bulunan asırlık bir meşe ağacının altında, Selçuklu "
                  "mimari tarzının görüldüğü bir türbede medfundur. Türbenin "
                  "bakımı köylüler tarafından yapılmaktadır."
                  "Durhasan dede; Çukurova velilerinde Misis kütüklü köyünde kabri"
                  " bulunan Cabbar Dede’nin kardeşidir. Bu zatı vesile ederek"
                  " yapılan duaların kabul olduğu yöre halkı tarafından söylenmektedir."
                  "Yaşadığı ve vefat ettiği tarihler kesin olarak bilinmektedir."
                  " Türbenin üzerindeki kitabeden 1287 tarihinde restore"
                  " edildiği anlaşılmaktadır."),

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
                Get.to(() => DurHasanYorum());
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
