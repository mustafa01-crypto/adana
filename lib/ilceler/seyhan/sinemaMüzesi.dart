import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/sinemaMuzesiYorum.dart';
import 'package:adana/map/map.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';
import 'package:rating_dialog/rating_dialog.dart';

late User loggedInuser;

class SinemaMuzesi extends StatefulWidget {
  const SinemaMuzesi({Key? key}) : super(key: key);

  @override
  _SinemaMuzesiState createState() => _SinemaMuzesiState();
}

class _SinemaMuzesiState extends State<SinemaMuzesi> with SingleTickerProviderStateMixin {


  double x = 36.988459;
  double y = 35.331943;
  String title = "ADANA SİNEMA MÜZESİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.gezilesiyer.com/wp-content/uploads/2019/04/adana-sinema-muzesi.jpg",
    "https://media-cdn.tripadvisor.com/media/photo-s/16/b5/58/86/20190301-164803-largejpg.jpg",
    "https://i1.wp.com/gezginimgezgin.com/wp-content/uploads/2020/04/3-15.jpg",
    "https://www.gezilesiyer.com/wp-content/uploads/2019/04/adana-sinema-muzesi-02.jpg",
    "https://i.pinimg.com/736x/31/01/80/3101800326daec771ecd6e65ed48efb9.jpg",
    "https://i.sozcu.com.tr/wp-content/uploads/2019/06/10/iecrop/y8_16_9_1560175560.jpg",
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
      message: 'Adana Sinema Müzesi hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/sinema.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("SinemaMuzesiYorum")
            .doc(loggedInuser.email)
            .set({
          'email': loggedInuser.email.toString(),
          'icerik': response.comment.toString(),
          'puan': response.rating.toString()
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
      appBar: AppBar(
        backgroundColor: sinir,
        title: Center(child: Text(title)),
        actions: [
          IconButton(
            onPressed: ()
            {
              MapUtils.openMap(x, y);
            },
            icon: Icon(Icons.map_sharp,color: Colors.white,),

          ),
          IconButton(
            onPressed: () {
              _showRatingAppDialog();
            },
            icon: Icon(
              Icons.comment_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ImageSlider(
                /// Shows the tab indicating circles at the bottom
                showTabIndicator: true,

                /// Cutomize tab's colors
                tabIndicatorColor: Colors.lightBlue.shade300,

                /// Customize selected tab's colors
                tabIndicatorSelectedColor: Colors.lightBlue.shade800,

                /// Height of the indicators from the bottom
                tabIndicatorHeight: 9,

                /// Size of the tab indicator circles
                tabIndicatorSize: 9,

                /// tabController for walkthrough or other implementations
                tabController: tabController,

                /// Animation curves of sliding
                curve: Curves.fastOutSlowIn,

                /// Width of the slider
                width: MediaQuery.of(context).size.width,

                /// Height of the slider
                height: 220,

                /// If automatic sliding is required
                autoSlide: true,

                /// Time for automatic sliding
                duration: new Duration(seconds: 3),

                /// If manual sliding is required
                allowManualSlide: true,

                /// Children in slideView to slide
                children: links.map((String link) {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: scaffold,
                      border: Border.all(color: sinir, width: 2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(color: Colors.blue.shade300, spreadRadius: 1)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Adana Sinema Müzesi, Türkiye'nin Adana kentinde bulunan "
                          "bir sinema müzesidir. Müze, 23 Eylül 2011 tarihinde eski "
                          "bir Adana evinde kurulmuş olup Seyhan ilçesine bağlı Kayalıbağ Mahallesi'nde Seyhan Nehri'nin batısında yer almaktadır. Özellikle şehre özgü yönetmenler, oyuncular ve yapımcılar ile ilgili eserler tanıtılmaktadır."

                       " Müzenin zemin katı film afişleri için ayrılmıştır. Posterdeki "
                          "en az bir isim (yönetmen, oyuncu, senarist vb.) "
                          "Adana sakinine aittir. Birinci katta, Yılmaz Güney'in "
                          "fotoğraflarını, film afişlerini ve eşyalarını gösteren "
                          "bir oda bulunmaktadır. Ayrıca Yılmaz Güney, ressam Abidin "
                          "Dino ve yazar Orhan Kemal'in heykelleri vardır. Adana'dan sinema ile ilgili diğer tanınmış kişilerin sergilendiği fotoğraflar ve eserler ise yazar Yaşar Kemal, oyuncu Şener Şen ve babası oyuncu Ali Şen, Muzaffer İzgü, Ali Özgentürk, Orhan Duru, Aytaç Arman, Bilal İnci, Merve Mahmut Hekimoğludur. Müzede bir de kütüphane bulunmaktadır.",
                      style: cityIcerik,
                  ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: ()
                {
                  Get.to(() => Maps(x: x, y: y, title: title));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Center(
                    child: Text(
                      "HARİTADA GÖSTER",
                      style: cityName,

                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
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
                  Get.to(() => SinemaMuzesiYorum());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Center(
                    child: Text(
                      "YORUMLARI GÖSTER",
                      style: cityName2,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: sinir,
                    border: Border.all(color: scaffold, width: 4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
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
