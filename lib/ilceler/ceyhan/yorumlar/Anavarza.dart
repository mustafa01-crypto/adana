import 'package:adana/comment_profile/comment_profile.dart';
import 'package:adana/components/mainAppBar.dart';
import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class AnavarzaYorum extends StatefulWidget {
  const AnavarzaYorum({Key? key}) : super(key: key);

  @override
  _AnavarzaYorumState createState() => _AnavarzaYorumState();
}

class _AnavarzaYorumState extends State<AnavarzaYorum> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: mainAppBar("YORUMLAR"),
        backgroundColor: kutu,
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
  double value = 1.0;

  @override
  Widget build(BuildContext context) {

    Query karapinarYorumlar =
    FirebaseFirestore.instance.collection('AnavarzaYorum');

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

                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 1 / 50),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: boxGradient,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Profiles(path: data['email']!),
                            Text(
                              data["email"],
                              style: emailText,
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 13),
                          child: Text(
                            data["icerik"],
                            style: yorumText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data["zaman"],
                                style: emailText,
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
                          ),
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


