import 'package:adana/constants/constants.dart';
import 'package:adana/map/mapUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';

import '../../map/map.dart';

class YanikKale extends StatefulWidget {
  const YanikKale({Key? key}) : super(key: key);

  @override
  _YanikKaleState createState() => _YanikKaleState();
}

class _YanikKaleState extends State<YanikKale> with SingleTickerProviderStateMixin {

  double x = 37.401150;
  double y = 35.193316;
  String title = "Yanıkkale";

  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "assets/karaisali/yanik/k1.jpg",
    "assets/karaisali/yanik/k2.jpg",

  ];

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

          )
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
                      child: Image.asset(
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
                      "Fındıklı mevkisinden başlayan yürüyüş Eğlence "
                          "Irmağı'ndan yapılan su geçişleriyle sürdü."
                          " Doğaseverler vadi dibinde inşa edilmiş "
                          "Yanıkkale’de anı fotoğrafları çektirdi. Yanıkkale"
                          " doğa yürüyüşü, Kuruca Pınar’da verilen "
                          "molanın ardından sona erdi. Etkinlik lideri"
                          " Murat Arıkan, Yanıkkale, Barakdağı ile Keçi"
                          " Kalesi arasında kalan vadi içerisinde Roma"
                          " döneminde kalan bir gözetleme kalesi.",
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
