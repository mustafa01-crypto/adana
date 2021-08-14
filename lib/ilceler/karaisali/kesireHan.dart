import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali/yorumlar/KesriHan.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../map/map.dart';

late User loggedInuser;
var now = new DateTime.now();
var formatter = new DateFormat('dd-MM-yyyy');
String formattedDate = formatter.format(now);

class KesireHan extends StatefulWidget {
  const KesireHan({Key? key}) : super(key: key);

  @override
  _KesireHanState createState() => _KesireHanState();
}

class _KesireHanState extends State<KesireHan>
    with SingleTickerProviderStateMixin {
  double x = 37.233194;
  double y = 35.162650;
  String title = "KESİRİ HAN";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 4, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHBO8UH8SYflsCp0O9mzXX39lw9VjBXeCo50TKJIL7qpO3JV5PbeHzHWJqRs5iOjYIjqk&usqp=CAU",
    "http://3.bp.blogspot.com/-RWc2RD1Ny08/VD-KEPdXEFI/AAAAAAAABmc/XI8Ut0-i9CQ/s1600/musttafa_yerkopru_21032010_481_2.jpg",
    "https://www.gidilmeli.com/sayfa/resim/6141fe25aa5dae5df8061e9dc237aa5c.jpg",
    "http://1.bp.blogspot.com/-TjTp_WvTbN4/VGhmMsq6xlI/AAAAAAAABvM/tB6joSbnOj0/s1600/Kesrikhan%2Byak%C4%B1ndan%2Bg%C3%B6r%C3%BCn%C3%BC%C5%9F.jpg",
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
      message: 'Kesri Han hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/karaisali/kesire/k4.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("kesriYorum")
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
        //backgroundColor: sinir,
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
              infoText("İçinde yaşadığımız coğrafya insanlık tarihinin en "
                  "önemli değişimlerine tanıklık etmiş binlerce"
                  " kültür mirasına sahip bir coğrafyadır. Ancak "
                  "şu da bir gerçektir ki bu tarihi mirası olması "
                  "gerektiği biçimde koruma, kollama ve yaşatma "
                  "görevlerini bu toplum yönetenler ve bu toplumun"
                  " bireyleri yerine getirememiştir. Kentlerimiz "
                  "günlük çıkarlara feda edilmiş, pek çok eser yok "
                  "edilmiş, yakılmış, yurt dışına kaçırılmış,"
                  " müzelerimizde sergilenmeden depolarda terk "
                  "edilmiş, alınmış, satılmış, mekânlar harabe "
                  "ve mezbele durumlara düşürülmüş bazen yenileme "
                  "adı altında aslı ile ilgisi olmayan formlara "
                  "dönüştürülmüştür. Korunmaya değer görülenler "
                  "ise dönemlerinin ekonomik, sosyal ve siyasal "
                  "koşullarınca belirlenmiştir. Oyda bugün insanlık "
                  "tarihi hakkında bildiklerimizin pek çoğu yıllara"
                  " meydan okuyan bu eserler sayesinde olmuştur."),
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
                    Get.to(() => KesriHanYorum());
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
                  child: buttonTextContainer(context,"HARİTADA GÖSTER")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
