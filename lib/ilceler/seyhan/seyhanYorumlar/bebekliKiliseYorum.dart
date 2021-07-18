import 'package:adana/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


class BebekliKiliseYorum extends StatefulWidget {
  const BebekliKiliseYorum({Key? key}) : super(key: key);

  @override
  _BebekliKiliseYorumState createState() => _BebekliKiliseYorumState();
}

class _BebekliKiliseYorumState extends State<BebekliKiliseYorum> {
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
        .collection('bebekliKiliseYorum');


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
                                VerticalDivider(
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                                kisaExpanded2(document, "puan"),
                              ],
                            ),
                          ],
                        )
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
          style: cityName,
        ));
  }
}
