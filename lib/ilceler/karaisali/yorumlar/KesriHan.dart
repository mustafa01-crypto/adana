import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';


class KesriHanYorum extends StatefulWidget {
  const KesriHanYorum({Key? key}) : super(key: key);

  @override
  _KesriHanYorumState createState() => _KesriHanYorumState();
}

class _KesriHanYorumState extends State<KesriHanYorum> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          title: Text(
            "YORUMLAR",
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradient2,
            ),
          ),

        ),
        backgroundColor: Colors.white,


        body: Yorumlar(),
      ),
    );
  }
}


class Yorumlar extends StatefulWidget {
  const Yorumlar({Key? key}) : super(key: key);

  @override
  State<Yorumlar> createState() => _YorumlarState();
}

class _YorumlarState extends State<Yorumlar> {
  @override
  Widget build(BuildContext context) {

    double value =1.0;
    Query karapinarYorumlar = FirebaseFirestore.instance
        .collection('kesriYorum');


    return StreamBuilder<QuerySnapshot>(

      stream: karapinarYorumlar.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1/11,
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*1/10),
                    decoration: BoxDecoration(
                      border: Border.all(color: scaffold, width: 4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Colors.white,

                    ),
                    child: IntrinsicHeight(
                        child: Column(
                          children: [
                            kisaExpanded2(document, "email"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                kisaExpanded2(document, "icerik"),
                                Divider(
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                                Row(
                                  children: [
                                    new RatingStars(
                                      value: data["puan"],
                                      onValueChanged: (v) {
                                        setState(() {
                                          value = v;
                                        });
                                      },
                                      starBuilder: (index, color) => Icon(
                                        Icons.star,
                                        color: color,
                                      ),
                                      starCount: 5,
                                      starSize: 20,
                                      valueLabelTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      valueLabelRadius: 10,
                                      maxValue: 5,
                                      starSpacing: 2,
                                      maxValueVisibility: true,
                                      valueLabelVisibility: true,
                                      animationDuration:
                                      Duration(milliseconds: 1000),
                                      valueLabelPadding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 8),
                                      valueLabelMargin:
                                      const EdgeInsets.only(right: 8),
                                      starOffColor: const Color(0xffe7e8ea),
                                      starColor: Colors.yellow,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },

    );
  }

  Widget kisaExpanded2(dynamic document, String doc) {
    return Expanded(

        child: new Text(document.data()[doc],
          style: cityName,
        ));
  }
}
