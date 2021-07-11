import 'package:adana/constants/constants.dart';
import 'package:adana/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';

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

  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "assets/karaisali/dokuzoluk/d1.jpg",
    "assets/karaisali/dokuzoluk/d2.jpg",
    "assets/karaisali/dokuzoluk/d3.jpg",
    "assets/karaisali/dokuzoluk/d4.jpg",
    "assets/karaisali/dokuzoluk/d5.jpg",
    "assets/karaisali/dokuzoluk/d6.jpg",
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
                  "DOKUZOLUK",
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
                      "Huzurumuzdu, huzursuzluğumuz oldu."
                      "Bizim Köprübaşı'mız vardı... Her mevsim bizim olan, köylülerimizin'"
                      ' olan, artık yok. Gölgesinde oturduğumuz çınarlarımız, suyunda'
                      "' serinlediğimiz özümüz vardı. Adil Hocanın hatırası "
                      "eski değirmenimiz, suyunu içtiğimiz pınarımız vardı, artık yok."
                      "Köprübaşında insanlar haya ile otururdu; edep vardı, haya vardı, artık yok."
                      "Yapımı sırasında olmasın dediğimizden dolayı soruşturma geçirdiğim Köprübaşı"
                      " artık tanımadığımız kişilerin oldu."
                      "Huzur bulduğumuz yer huzursuzluğumuz oldu. Çünkü içenler, sıç..lar,"
                      " hırlısı, hırsızı gelmeye başladı. Utanmadan"
                      " arabanın sesini açıp; atletle, şortla geçen insanlar(!) gelmeye başladı."
                      "Hangi köylüme sorsam Yıllar oldu gitmeyeli, görmeyeli diyorlar. "
                      "Sadece yoldan geçiyoruz, bir su içmeye, elimizi yüzümüzü"
                      " yıkayıp serinlemek için bile durmaya utanıyoruz"
                      "diyorlar."
                      "Evimize bir fıçı su doldurduğumuz, pınarından su "
                      "içtiğimiz, elimizi yüzümüzü yıkadığımız, "
                      "abdest alıp namaz kıldığımız Köprübaşı'mız yok artık!",
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
                  Get.to(() => Maps(
                        x: x,
                        y: y,
                        title: title,
                      ));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
