import 'package:adana/constants/constants.dart';
import 'package:adana/ilceler/karaisali.dart';
import 'package:adana/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => Karaisali());
                  },
                  child: sehirler("Karaisalı")),
              sehirler("Seyhan"),
              sehirler("Ceyhan"),
              sehirler("Pozantı"),
              sehirler("Kozan"),
              sehirler("Feke"),
              sehirler("Saimbeyli"),
              sehirler("Tufanbeyli"),
              sehirler("Yumurtalık"),
              sehirler("Karataş"),
            ],
          ),
        ),
      ),
    );
  }

  Widget sehirler(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(

                text,
                style: cityName,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width/3,),
            IconButton(
              iconSize: 35,
              onPressed:()
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Map()));
              },
              icon: Icon(Icons.map_rounded),
              color: Colors.white,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade100,
          border: Border.all(color: Colors.blueAccent, width: 2),
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
    );
  }
}
