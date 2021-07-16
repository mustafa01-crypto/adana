import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


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


class Yorumlar extends StatelessWidget {
  const Yorumlar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Query karapinarYorumlar = FirebaseFirestore.instance
        .collection('yorumlar');


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
            return Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    //margin: EdgeInsets.only(top: 5,bottom: 5),
                    width: double.infinity,
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: sinir,
                      //Color(0xFF5E808A  ),//2E61EE
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kisaExpanded2(document, "email"),
                          VerticalDivider(
                            thickness: 2,
                            color: Color(0xFFF6F4F4),
                          ),
                          kisaExpanded2(document, "icerik"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.only(top: 5,bottom: 5),
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        color: sinir),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kisaExpanded2(document, "puan"),
                          VerticalDivider(
                            thickness: 2,
                            color: Color(0xFFF6F4F4),
                          ),
                          kisaExpanded2(document, "tarih"),
                        ],
                      ),
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

  Widget kisaExpanded2(dynamic document, String doc) {
    return Expanded(
        child: new Text(document.data()[doc],
          style: cityIcerik,
           ));
  }
}
