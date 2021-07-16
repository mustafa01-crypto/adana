import 'dart:io';

import 'package:adana/auth/login.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/mesire/karaisaliMesire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:video_player/video_player.dart';

late User loggedInuser;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VideoPlayerController? _controller;
  File? yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirmeBaglantisi;

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        loggedInuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getCurrentUser();
    baglantiAl();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/adana-319111.appspot.com/o/karaisal%C4%B1%20video%2FAdana%20Tan%C4%B1t%C4%B1m%20Filmi.mp4?alt=media&token=4743104e-7578-4edd-968a-81ad8c773f17")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller!.play();
        _controller!.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("profilresimleri")
        .child(loggedInuser.email!)
        .child("profilResmi.png")
        .getDownloadURL();

    setState(() {
      indirmeBaglantisi = baglanti;
    });
  }

  kameradanYukle() async {
    var alinanDosya = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("profilresimleri")
        .child(loggedInuser.email!)
        .child("profilResmi.png");

    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya!);
    String url = await (await yuklemeGorevi.whenComplete(() => null))
        .ref
        .getDownloadURL();
    setState(() {
      indirmeBaglantisi = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: sinir,
            centerTitle: true,
            title: Text(
              "DİYAR DİYAR ADANA",
            ),
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((deger) {
                    Get.to(() => Login());
                  });
                },
                icon: Icon(Icons.exit_to_app),
              )
            ],
          ),
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
              ),
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      width: width * 3 / 10,
                      height: width * 2 / 5,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(color: Colors.white.withOpacity(0.4))
                      ], gradient: gradient, shape: BoxShape.circle),
                      child: InkWell(
                        onTap: () {
                          kameradanYukle();
                        },
                        child: Center(
                          child: ClipOval(
                              child: indirmeBaglantisi == null
                                  ? Image.asset(
                                      "assets/profile.png",
                                      width: width * 3 / 10,
                                      height: width * 2 / 5,
                                    )
                                  : Image.network(
                                      indirmeBaglantisi!,
                                      width: width * 3 / 10,
                                      height: width * 2 / 5,
                                      fit: BoxFit.fill,
                                    )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 1 / 20,
                  ),
                  ListTile(
                    title: Text('KARAİSALI', style: baslik2),
                    onTap: () {
                      Get.to(() => KaraisaliMesireList());
                    },
                  ),
                  ListTile(
                    title: Text('SEYHAN', style: baslik2),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('CEYHAN', style: baslik2),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      'KOZAN',
                      style: baslik2,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      'POZANTI',
                      style: baslik2,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('YUMURTALIK', style: baslik2),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('KARATAŞ', style: baslik2),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.size.width,
                    height: _controller!.value.size.height,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
