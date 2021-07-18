import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali/yorumlar/kanyon.dart';
import 'package:adana/map/map.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';
import 'package:rating_dialog/rating_dialog.dart';

late User loggedInuser;

class Kanyon extends StatefulWidget {
  const Kanyon({Key? key}) : super(key: key);

  @override
  _KanyonState createState() => _KanyonState();
}

class _KanyonState extends State<Kanyon> with SingleTickerProviderStateMixin {

  double x = 37.233555;
  double y = 35.014943;
  String title = "KAPIKAYA KANYONU";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://i2.milimaj.com/i/milliyet/75/0x410/5f6e6d1dadcdeb162c8cca69.jpg",
    "https://media.istockphoto.com/photos/suspension-bridge-in-turkey-with-wood-walkwayadanakaraisali-picture-id978360234?k=6&m=978360234&s=170667a&w=0&h=WsdbgTOCxi8dsEQsVCkv8oSCakP5t4EX5EmcKMvDjvo=",
    "https://i.pinimg.com/originals/a3/c4/6e/a3c46ebdebc51da8f00ba39d54560808.jpg",
    "https://www.gezivetatilrehberi.com/resimler/sehir/adana/gezi/adana-kapikaya-kanyonu-16121163801.jpg",
    "https://www.gezenbilir.com/attachments/dsc_4832-jpg.307310/",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlO-5wY9xI7DOSIXjmArxTj0zYB8o1kOuYAw&usqp=CAU",
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
      message: 'Kapıkaya Kanyonu hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/karaisali/kanyon/k5.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("kanyonYorum")
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
                      "Kapıkaya Kanyonu, Adana ili Karaisalı ilçesinde "
                          "Kapıkaya köyünde bulunan kanyon."

                          "Kanyonu Seyhan Nehri'nin kollarından Çakıt'"
                          " Deresi açmıştır. Çakıt Deresi, Seyhan Nehri'"
                          "nin Batı koludur. Pozantı Boğazından dağlık "
                          "alanlara doğru uzanır. Kanyon Varda Köprüsü'ne '"
                          "'2 km uzaklığındadır."
                          "Kanyon çevresinde bitki örtüsü; zakkum, "
                          " zeytin, keçiboynuzu ve çınar ağaçlarından "
                          "oluşur. 20 km'lik kanyonun 7,25 km'si yürüyüş"
                          "yolu olarak düzenlenmiş, doğa yürüyüşleri yapılmaktadır."
                          "Kanyonun doğa turizmi için cazibe merkezi haline getirilmesine"
                          "çalışılmaktadır. Yerköprü piknik alanı ile kanyon yolu yeni"
                          "yapılan bir köprü ile birleştirilmiştir. 7,250 m yürüyüş yolu "
                          "düzenlenmiş, şelaleyi görecek bir alana ahşap seyir terası"
                          "yapılmıştır. Sarp olan 400 metrelik kısma korkuluk yapılıp,"
                          "dar alanlarda yol genişletilmiştir.",
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
                  Get.to(() => KanyonYorum());
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
