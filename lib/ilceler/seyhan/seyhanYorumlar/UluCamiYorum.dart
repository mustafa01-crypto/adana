import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class UluCamiYorum extends StatefulWidget {
  const UluCamiYorum({Key? key}) : super(key: key);

  @override
  _UluCamiYorumState createState() => _UluCamiYorumState();
}

class _UluCamiYorumState extends State<UluCamiYorum> {
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
              gradient: xdGradient,
            ),
          ),
        ),
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
        FirebaseFirestore.instance.collection('UluCamiYorum');



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
                      //  border: Border.all(color: scaffold, width: 4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: sol,
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
                              style: email,
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          data["icerik"],
                          style: xdBeyaz,
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

class Profiles extends StatefulWidget {
  String? path;

  Profiles({required this.path});

  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {

  String? indirmeBaglantisi;

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("profilresimleri")
        .child(widget.path!)
        .child("profilResmi.png")
        .getDownloadURL();

    setState(() {
      indirmeBaglantisi = baglanti;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baglantiAl();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 1 / 9,
      height: width * 1 / 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
            child: indirmeBaglantisi == null
                ? Image.asset(
              "assets/profile.png",
              width: width * 1 / 10,
              height: width * 1 / 9,
              fit: BoxFit.cover,
            )
                : Image.network(
              indirmeBaglantisi!,
              width: width * 1 / 10,
              height: width * 1 / 9,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
