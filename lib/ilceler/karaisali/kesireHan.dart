import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';

import '../../map.dart';

class KesireHan extends StatefulWidget {
  const KesireHan({Key? key}) : super(key: key);

  @override
  _KesireHanState createState() => _KesireHanState();
}

class _KesireHanState extends State<KesireHan> with SingleTickerProviderStateMixin {


  double x = 37.233194;
  double y = 35.162650;
  String title = "KESİRİ HAN";

  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "assets/karaisali/varda/v1.jpg",
    "assets/karaisali/varda/v2.jpg",
    "assets/karaisali/varda/v3.jpg",
    "assets/karaisali/varda/v4.jpg",
    "assets/karaisali/varda/v5.jpg",
    "assets/karaisali/varda/v6.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Image.asset(
                        link,
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        fit: BoxFit.fill,
                      ));
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "KESİRİ HAN",
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
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
                      "İçinde yaşadığımız coğrafya insanlık tarihinin en "
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
                          " meydan okuyan bu eserler sayesinde olmuştur.",
                      style: cityIcerik,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
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
                    color: scaffold,
                    border: Border.all(color: Colors.blueAccent.shade100, width: 4),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
