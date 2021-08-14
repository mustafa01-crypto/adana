import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/cukurova/yorumlar/park.dart';
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

class DogalPark extends StatefulWidget {
  const DogalPark({Key? key}) : super(key: key);

  @override
  _DogalParkState createState() => _DogalParkState();
}

class _DogalParkState extends State<DogalPark>
    with SingleTickerProviderStateMixin {
  double x = 37.0501546;
  double y = 35.2526337;
  String title = "Çukurova Doğal Park";
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
    "https://www.adanadacocukolmak.com/wp-content/uploads/2017/06/IMG_5466-500x300.jpg",
    "https://mapio.net/images-p/11663891.jpg",
    "https://www.adanadacocukolmak.com/wp-content/uploads/2016/10/Resul_GUL_Dogalpark-e1489673203320-500x300.jpg",
    "https://www.adanadacocukolmak.com/wp-content/uploads/2016/10/do%C4%9Falpark2-500x300.jpg",
    "https://i.ytimg.com/vi/Ye5dAkFMr8Q/maxresdefault.jpg",
    "https://www.adanadacocukolmak.com/wp-content/uploads/2016/10/do%C4%9Falpark-500x300.jpg"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://mapio.net/images-p/11663891.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("ParkYorum")
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
              infoText("Çukurova Belediyesi tarafından ilçenin içerisine yapılan bu park"
                  " gerçekten dikkat çekici bir kullanım yapısına sahiptir."
                  " İçerisinde akarsular, piknik alanları, kuşlar ve farklı "
                  "hayvan türleri bulunmaktadır. "
                  " İlçede yaşayanlar genellikle sıcak havada bu parkı ziyaret "
                  "etmeyi tercih etmektedir. İçinde ayrıca amfi tiyatro,"
                  " konser alanları ve gösteri noktaları da yer almaktadır."
                  " Ayrıca düğün salonu hizmet vermektedir. Merkezi bir "
                  "noktada olduğu için biraz dinlenmek ve rahatlamak için "
                  "bu parka kolayca ulaşmanız mümkündür."),
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
                child: buttonTextContainer(context,"YORUM YAP")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
