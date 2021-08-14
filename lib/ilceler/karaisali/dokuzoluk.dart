import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali/yorumlar/dokuzoluk.dart';
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
class Dokuzoluk extends StatefulWidget {
  const Dokuzoluk({Key? key}) : super(key: key);

  @override
  _DokuzolukState createState() => _DokuzolukState();
}

class _DokuzolukState extends State<Dokuzoluk>
    with SingleTickerProviderStateMixin {
  double x = 37.387938;
  double y = 35.209563;
  String title = "Dokuzoluk";
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
    "https://media-cdn.tripadvisor.com/media/photo-s/0c/f9/48/fc/muhtesem-manzara.jpg",
    "https://seyyahdefteri.com/wp-content/uploads/2019/05/dokuzoluk-piknik-alani-4.jpg",
    "https://seyyahdefteri.com/wp-content/uploads/2019/05/Dokuzoluk-Piknik-Alani.png",
    "https://www.serpmekahvalti.com/wp-content/uploads/2020/10/143024851_zrISGdG19Jvo7DCZjabGE1XEC3JfkyPmRrJTVCGGi64.jpg",
    "https://www.kampusulasi.com/wp-content/uploads/2021/03/Dokuzoluk-1-1080x738.jpg",
    "https://foto.haberler.com/haber/2013/08/01/doga-harikasi-dokuzoluk-2-4895535_o.jpg",
  ];
  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: 'Dokuzoluk hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/karaisali/dokuzoluk/d5.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("dokuzolukYorum")
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
                      "Dokuzoluk piknik alanı bir kanyonun hemen kenarında çeşitli "
                          "noktalardan fışkıran pınarlar, yemyeşil bitki örtüsü ve"
                          " ziyaretçilerin buz gibi suyunda serinledikleri göletlerden"
                          " oluşmaktadır. Piknik yapmak, yüzmek, balık tutmak,"
                          " yürüyüş yapmak, fotoğraf çekmek burada gerçekleştirilebilecek"
                          " aktiviteler arasındadır. Köprünün üzerinden kanyon manzarasının "
                          "fotoğrafının çekilmesi tavsiye edilir."
                      "Dokuzoluk’ta ziyaretçilerin piknik için kullanabilecekleri "
                          "masalar, kamelyalar, mangal alanları, mescit, çeşme ve tuvaletler"
                          " bulunmaktadır. Giriş ücreti 10 TL’dir. Özellikle Adana’nın "
                          "sıcağından uzaklaşmak, farklı ve dinlendirici bir doğa harikasında"
                          " gününü geçirmek isteyenler tarafından tercih edilmektedir.",
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
                  Get.to(() => DokuzolukYorum());
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
