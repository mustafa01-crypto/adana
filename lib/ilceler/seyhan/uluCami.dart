import 'package:adana/components/buttonText.dart';
import 'package:adana/components/infoText.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/components/sliderImage.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/seyhan/seyhanYorumlar/UluCamiYorum.dart';
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

class UluCamii extends StatefulWidget {
  const UluCamii({Key? key}) : super(key: key);

  @override
  _UluCamiiState createState() => _UluCamiiState();
}

class _UluCamiiState extends State<UluCamii>
    with SingleTickerProviderStateMixin {
  double x = 36.985050;
  double y = 35.330837;
  String title = "ULU CAMİİ";
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "https://okuryazarim.com/wp-content/uploads/2016/12/Adana-Ulu-Cami-Genel.jpg",
    "https://www.gezipedia.net/uploads/posts/2020-03/1585517792_adana-ulu-cami.jpg",
    "https://tarihiyapi.net/wp-content/uploads/2020/05/Adana-Ulu-Cami-Tarihi.jpg",
    "https://www.kulturportali.gov.tr/contents/images/asde.jpg",
    "https://www.otelcenneti.com/uploads/resimler/adana-ulu-camii-2.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs_doxoEGOGxV07G3j9C_-xH5DndTllcJIHA&usqp=CAU",
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
      message: 'Yerköprü hakkında ne düşünüyorsunuz',
      image: Image.asset(
        "assets/alu.jpg",
        height: 100,
      ),
      submitButton: 'Gönder',
      onCancelled: () {},
      onSubmitted: (response) {
        FirebaseFirestore.instance
            .collection("UluCamiYorum")
            .doc(loggedInuser.email)
            .set({
          'zaman': formattedDate.toString(),
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
                  "Ulu Cami büyüklüğü ve tarihî açısından Adana'nın önemli "
                  "eserleri arasında gösterilmektedir. Selçuklu, Memlûklu"
                  " ve Osmanlılar Dönem'lerine ait mimarî karakterleri"
                  " üzerinde toplayan bu eserin üç ayrı kitabesinden,"
                  " ilk defa 1513 yıllarında Ramazan oğlu Halil Bey"
                  " tarafından inşasına başlandığı, 1541 yılında Halil"
                  " Beyin oğlu Piri Mehmet Paşa tarafından bitirilerek "
                  "ibadete açıldığı anlaşılmaktadır."),
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
                Get.to(() => Maps(),);
              },
              child: buttonTextContainer(context, "HARİTADA GÖSTER")),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => UluCamiYorum());
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
