import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/yorumlar/Anavarza.dart';
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

class Anavarza extends StatefulWidget {
  const Anavarza({Key? key}) : super(key: key);

  @override
  _AnavarzaState createState() => _AnavarzaState();
}

class _AnavarzaState extends State<Anavarza>
    with SingleTickerProviderStateMixin {
  double x = 37.247293;
  double y = 35.900924;
  String title = "Anavarza Kalesi";
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

    "https://cdnuploads.aa.com.tr/uploads/Contents/2018/08/06/thumbs_b_c_9e6375297d46cc38d01fa70e293d49a3.jpg",
    "https://blog.tatildukkani.com/wp-content/uploads/2018/10/anavarza-antik-kenti-kapak.jpg",
    "https://img.bilgihanem.com/wp-content/uploads/2016/02/anavarza-kalesi-hakkinda-bilgiler.jpg",
    "https://adanabaska.com/thumb.php?src=files/anavarzajpg_31-05-2018_15-43-57.jpg&size=1094x715"

  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '${title} hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://adanabaska.com/thumb.php?src=files/anavarzajpg_31-05-2018_15-43-57.jpg&size=1094x715",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("AnavarzaYorum")
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
              infoText("Tarihi 2100 yıl öncesine giden ve en parlak dönemini Roma"
              " İmparatoru Septimius Severus’un ödüllendirmesiyle "
              "M.S. 2'nci yüzyılda yaşamaya başlayan Anavarza, zaman içinde"
              " önemli bir kent haline gelerek 408 yılında Kilikya Başkenti"
              " unvanına kavuşmuştur. Bizans Dönemi’nde önemini devam ettiren, "
              "sonraki yıllarda Ermeniler, Abbasiler, Selçuklular, Ramazanoğulları, "
                "Osmanlılar gibi çeşitli medeniyetlere ev sahipliği yapan Anavarza’da"
                " farklı kültürlere ait izleri bir arada görmek mümkün. Bu kültürel "
                "zenginliği sayesinde de UNESCO Dünya Miras Geçici Listesi’nde yer"
                " alması uygun görülen kent; kalıntıları, tarihi ve efsaneleri ile dikkat çekiyor."),
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
                child: buttonTextContainer(context,"HARİTADA GÖSTER"),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => AnavarzaYorum());
                },
                child: buttonTextContainer(context,"YORUMLARI GÖSTER"),
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
