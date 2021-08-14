import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/cobanDedeYorum.dart';
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

class CobanDede extends StatefulWidget {
  const CobanDede({Key? key}) : super(key: key);

  @override
  _CobanDedeState createState() => _CobanDedeState();
}

class _CobanDedeState extends State<CobanDede> with SingleTickerProviderStateMixin {


  double x = 37.062775;
  double y = 35.301432;
  String title = "ÇOBAN DEDE";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.nenerede.com.tr/wp-content/uploads/2017/03/%C3%87oban-Dede-Park%C4%B13.jpg",
    "https://www.tatilana.com/wp-content/uploads/2015/08/AdanaC387obanDedeTC3BCrbesi.jpg",
    "https://pclove.tripod.com/wallpaper3.jpg",
    "https://media-cdn.tripadvisor.com/media/photo-s/19/38/11/c1/coban-dede-park-i.jpg",
    "https://seyyahdefteri.com/wp-content/uploads/2019/05/%C3%87oban-Dede-T%C3%BCrbesi-ve-Park%C4%B1-2.jpg",
    "https://www.adanadacocukolmak.com/wp-content/uploads/2016/10/%C3%A7oban-dede-3-500x300.jpg",
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
      message: 'Çoban Dede hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/dede.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("CobanDedeYorum")
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: xdArka,
                      border: Border.all(color: xdArka, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, -3), // changes position of shadow
                        ),
                      ]

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                    child: Text(
                      "Çoban Dede Türbesinin ve Parkın bulunduğu alanın bir "
                          "kısmı 2015 yılında kuş cenneti ve mini hayvanat bahçesine "
                          "dönüştürüldü. Hayvanat bahçesinde memeliler, su kuşları,"
                          " yırtıcı kuşlar, süs tavukları gibi hayvanlar yer almaktadır. "
                          "Küçük bir göletin etrafında yer alan hayvanların dışında "
                          "hayvanların için veterinerler ve poliklinikte bulunmaktadır. "
                          "Doğal yaşamda bir şekilde yaralanmış ve hasta olmuş hayvanlar "
                          "burada iyileştirilerek rehabilite edilmekte ve gelen misafirlerle tanıştırılmaktadır.",
                      style: xdUzunYazi,
                    ),
                  ),
                ),
              ),
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "HARİTADA GÖSTER",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //border: Border.all(color: kutu, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, -3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => CobanDedeYorum());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "YORUMLARI GÖSTER",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //  border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, -3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),

              //xd
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  MapUtils.openMap(x, y);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "YOL TARİFİ",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //border: Border.all(color: kutu, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, -3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  _showRatingAppDialog();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      "YORUM YAP",
                      style: cityName,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: xdArka,
                    //  border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, -3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
