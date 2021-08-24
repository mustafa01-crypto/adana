import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/ceyhan/yorumlar/yilankale.dart';
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

class YilanKale extends StatefulWidget {
  const YilanKale({Key? key}) : super(key: key);

  @override
  _YilanKaleState createState() => _YilanKaleState();
}

class _YilanKaleState extends State<YilanKale>
    with SingleTickerProviderStateMixin {
  double x = 37.0181955;
  double y = 35.7523007;
  String title = "Yılankale";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 5, vsync: this);
  }

  void getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loggedInuser = user;
    }
  }

  TabController? tabController;

  static List<String> links = [
    "https://www.kulturportali.gov.tr/contents/images/20180907111604258_yilan%20kale%20logolu.jpg",
    "https://ia.tmgrup.com.tr/ff648a/0/0/0/0/800/451?u=https://i.tmgrup.com.tr/fikriyat/2018/05/16/efsaneler-kalesi-yilankale-1526470807530.jpg&mw=660",
    "https://www.serpmekahvalti.com/wp-content/uploads/2020/11/Yilanli-Kale-Hakkinda.jpeg",
    "https://avatars.mds.yandex.net/get-altay/1514203/2a00000167fb962bef4b07b37f27c290aea4/XXL",
    "https://www.nkfu.com/wp-content/uploads/2014/04/yilan-kale-1.jpg"
  ];

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: title,
      commentHint: "...",
      message: '$title hakkında ne düşünüyorsunuz',
      image: Image.network(
        "https://www.nkfu.com/wp-content/uploads/2014/04/yilan-kale-1.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("YilanYorum")
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

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                "Toros Dağları’nı aşarak Antakya’ya giden tarihi İpek Yolu "
                "üzerinde yer alan Yılan Kalesi, Orta Çağ’da Çukurova'nın"
                " Haçlı işgali döneminde Bizanslılar tarafından yapılmıştır."
                " Anavarza, Tumlu ve Kozan Kaleleri gibi ovadaki"
                " diğer kaleleri de görüş alanının içine alan"
                " kalenin sekiz yuvarlak burcu vardır. Kalenin "
                "güneyinde yer alan nizamiye kapısından itibaren "
                "taş basamaklı merdivenlerle teraslara çıkılmaktadır. "
                "Kilise ve sarnıcı bulunan kalenin garnizonu en üst "
                "bölümde yer almıştır. Sarp kayalar üzerine yapılmış"
                " olan kalenin önemli bir sanat değeri vardır."),

            SizedBox(
              height: 15,
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                icon: Icon(Icons.arrow_circle_up,color: Colors.black,size: 40,),
                onPressed: () {
                  Get.bottomSheet(buildSheet(),
                      barrierColor: Colors.white.withOpacity(0.6),
                      isScrollControlled: false);
                },
              ),
            )

          ],
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
                Get.to(() => YilanYorum());
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