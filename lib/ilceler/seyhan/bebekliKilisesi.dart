import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/bebekliKiliseYorum.dart';
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

class BebekliKilisesi extends StatefulWidget {
  const BebekliKilisesi({Key? key}) : super(key: key);

  @override
  _BebekliKilisesiState createState() => _BebekliKilisesiState();
}

class _BebekliKilisesiState extends State<BebekliKilisesi>
    with SingleTickerProviderStateMixin {
  double x = 36.9873869;
  double y = 35.3256733;
  String title = "BEBEKLİ KİLİSESİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.kulturportali.gov.tr/repoKulturPortali/large/27032013/e2dcb4fa-d90b-4f55-8e08-fe1c4071eac8.jpg?format=jpg&quality=50",
    "https://www.kulturportali.gov.tr/repoKulturPortali/Dokumanlar/ADANABEBEKLIKILISEATILLAANDIRIN_20160411152215803.jpg?format=jpg&quality=50",
    "https://gezimanya.com/sites/default/files/inline-images/bebekli-kilise.jpg",
    "https://media-cdn.tripadvisor.com/media/photo-s/0e/97/97/2b/bebekli-kilise.jpg",
    "https://n8b8m5z7.stackpathcdn.com/wp-content/uploads/2019/07/bebekli-kilise.jpg",
    "https://mekan360.com/placephotos/1932/bebekli-kilisesi-adana_5.jpg",
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
      message: 'Bebekli Kilisesi hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/kilise.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("bebekliKiliseYorum")
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
                      "Adana Bebekli Kilise veya Aziz Pavlus Kilisesi, "
                      "üzerinde Meryem'in tunçtan heykelinin bulunduğu, tahminen 1880-90"
                      " yılları arasında yapılan Adana'nın merkezindeki İtalyan katolik"
                      " kilisesidir. Ermeni Apostolik Kilisesi olarak inşa edilmiştir."
                      " 1915 Ermeni Kırımı'ndan sonra Adana'da Ermeni cemaat kalmamıştır "
                      "ve Bebekli kilise Katolik Cemaate verilmiştir. Kilisenin tepesindeki "
                      "Meryem Ana’nın 2.5 metrelik tunç heykeli bebeğe benzetildiği için "
                      "halk arasında Kilisenin ismi Bebekli Kiliseolarak geçer. Kilise Pavlus"
                      " adına yaptırılmıştır."
                      " Kilise hem katolik cemaati, hem de Protestan Cemaati tarafından kullanılmaktadır.",
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
                  Get.to(() => BebekliKiliseYorum());
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
