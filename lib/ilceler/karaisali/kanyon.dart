import 'package:adana/constants/constants.dart';
import 'package:adana/map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';

class Kanyon extends StatefulWidget {
  const Kanyon({Key? key}) : super(key: key);

  @override
  _KanyonState createState() => _KanyonState();
}

class _KanyonState extends State<Kanyon> with SingleTickerProviderStateMixin {

  double x = 37.233555;
  double y = 35.014943;
  String title = "KAPIKAYA KANYONU";

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
                  "KAPIKAYA KANYONU",
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
                      "Kapıkaya Kanyonu, Adana ili Karaisalı ilçesinde "
                          "Kapıkaya köyünde bulunan kanyon."

                          "Kanyonu Seyhan Nehri'nin kollarından Çakıt'"
                          " Deresi açmıştır. Çakıt Deresi, Seyhan Nehri'"
                          "nin Batı koludur. Pozantı Boğazından dağlık "
                          "alanlara doğru uzanır. Kanyon Varda Köprüsü'ne '"
                          "'2 km uzaklığındadır."
                          "Kanyon çevresinde bitki örtüsü; zakkum, "
                          " zeytin, keçiboynuzu ve çınar ağaçlarından "
                          "oluşur. 20 km'lik kanyonun 7,25 km'si yürüyüş"
                          "yolu olarak düzenlenmiş, doğa yürüyüşleri yapılmaktadır."
                          "Kanyonun doğa turizmi için cazibe merkezi haline getirilmesine"
                          "çalışılmaktadır. Yerköprü piknik alanı ile kanyon yolu yeni"
                          "yapılan bir köprü ile birleştirilmiştir. 7,250 m yürüyüş yolu "
                          "düzenlenmiş, şelaleyi görecek bir alana ahşap seyir terası"
                          "yapılmıştır. Sarp olan 400 metrelik kısma korkuluk yapılıp,"
                          "dar alanlarda yol genişletilmiştir.",
                      style: cityIcerik,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: ()
                {
                  Get.to(() => Map(x: x, y: y, title: title));
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
