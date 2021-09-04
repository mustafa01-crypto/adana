import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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

    super.initState();
    baglantiAl();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 1 / 10,
      height: width * 1 / 10,
      child: ClipOval(
          child: indirmeBaglantisi == null
              ? Image.asset(
            "assets/profile.png",
            width: width * 1 / 10,
            height: width * 1 / 10,
            fit: BoxFit.cover,
          )
              : Image.network(
            indirmeBaglantisi!,
            width: width * 1 / 10,
            height: width * 1 / 10,
            fit: BoxFit.cover,
          )),
    );
  }
}