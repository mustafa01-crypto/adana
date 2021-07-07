import 'package:adana/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_slider/image_slider.dart';

class Karaisali extends StatefulWidget {
  const Karaisali({Key? key}) : super(key: key);

  @override
  _KaraisaliState createState() => _KaraisaliState();
}

class _KaraisaliState extends State<Karaisali> with SingleTickerProviderStateMixin {

  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
  }

  TabController? tabController;

  static List<String> links = [
    "assets/images/adana.jpg",
    "assets/images/adana1.jpg",
    "assets/images/adana2.jpg",
    "assets/images/adana3.jpeg",
    "assets/images/adana4.jpeg",
    "assets/images/adana5.jpeg",
    "assets/images/adana6.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffold,
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
                  "ADANA",
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: deniz,
                      border: Border.all(color: sinir,width: 2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(color: Colors.blue.shade300, spreadRadius: 1)
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Adana’ya ait en eski yazılı kayıtlara ilk defa, Anadolu "
                          "yarımadasının en köklü uygarlıklarından biri olan Hititlerin"
                          " kaya kitabelerinde rastlanmaktadır. Boğazköy metinleri olarak "
                          "bilinen M.Ö. 1650 yıllara tarihlenen bir Hitit tabletinde, Adana"
                          " havalisinden URU ADANIA yani ADANA BÖLGESI olarak bahsedilmektedir."
                          " Bu konuda sadece bu tablet dikkate alınacak"
                          " olsa bile ADANA ismi en az 3640 yıllık bir geçmişe sahiptir.Eski ",


                      style: cityIcerik,
                    ),
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
