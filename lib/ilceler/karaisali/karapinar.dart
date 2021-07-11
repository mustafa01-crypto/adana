import 'package:adana/constants/constants.dart';
import 'package:adana/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';

class Karapinar extends StatefulWidget {
  const Karapinar({Key? key}) : super(key: key);

  @override
  _KaraisaliState createState() => _KaraisaliState();
}

class _KaraisaliState extends State<Karapinar>
    with SingleTickerProviderStateMixin {

  double x = 37.261862;
  double y = 35.058648;
  String title = "Karapınar Parkı";

  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "assets/karaisali/park/k.jpg",
    "assets/karaisali/park/k1.jpg",
    "assets/karaisali/park/k2.jpg",
    "assets/karaisali/park/k3.jpg",
    "assets/karaisali/park/k4.jpg",
    "assets/karaisali/park/k5.jpg",
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
              Get.to(() => Maps(x: x, y: y, title: title));
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
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "KARAPINAR PARKI",
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
                      "Türkiye’nin Akdeniz Bölgesinde bulunan"
                      " Karaisalı, Roma Döneminden önemli izler taşıyan"
                      " ilçe konumuna sahip olan bir bölgedir. Bu ilçe,"
                      " soyunun Ramazanoğulları ve Menemencioğullarından geldiği"
                      " günümüzdeki adını"
                      " da Ramazanoğullarından Kara İsa Bey’den aldığı bilinen bir husustur.",
                      style: cityIcerik,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: ()
                {
                  Get.to(() => Maps(x: x,y: y,title: title,));
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
