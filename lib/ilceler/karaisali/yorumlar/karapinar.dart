import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ParkYorum extends StatefulWidget {
  const ParkYorum({Key? key}) : super(key: key);

  @override
  _ParkYorumState createState() => _ParkYorumState();
}

class _ParkYorumState extends State<ParkYorum> {
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

  String? url;
  double value = 1.0;
  Query karapinarYorumlar =
  FirebaseFirestore.instance.collection('karaipinarYorum');



  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
      stream: karapinarYorumlar.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //height: MediaQuery.of(context).size.height * 1/8,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 1 / 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: scaffold, width: 4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              data["email"],
                              style: email,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          data["icerik"],
                          style: icerik,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data["zaman"],
                              style: email,
                            ),
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
                              starSize: 24,
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
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.amber,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
