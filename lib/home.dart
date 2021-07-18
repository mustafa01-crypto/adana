import 'dart:io';
import 'package:adana/auth/login.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/mesire/karaisaliMesire.dart';
import 'package:adana/mesire/seyhanList.dart';
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
      final user = auth.currentUser;
      if (user != null) {
        loggedInuser = user;
      }

  }

  void initState() {
    super.initState();
    getCurrentUser();
    baglantiAl();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset(
        "assets/video/as.mp4")
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
    //final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(

            centerTitle: true,
            title: Text(
              "DİYAR DİYAR ADANA",
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradient2,
              ),
            ),

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            kameradanYukle();
                          },
                          child: Center(
                            child: ClipOval(
                                child: indirmeBaglantisi == null
                                    ? Image.asset(
                                  "assets/profile.png",
                                  width: width * 3 / 10,
                                  height: width * 2 / 7,
                                  fit: BoxFit.cover,
                                )
                                    : Image.network(
                                  indirmeBaglantisi!,
                                  width: width * 3 / 10,
                                  height: width * 2 / 7,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),

                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(loggedInuser.email.toString(),style: cityName,),
                    ],
                  ),
                  Divider(color: Colors.white,thickness: 2,),

                  ListTile(
                    title: Text('KARAİSALI', style: baslik2),
                    onTap: () {
                      Get.to(() => KaraisaliMesireList());
                    },
                  ),
                  ListTile(
                    title: Text('SEYHAN', style: baslik2),
                    onTap: () {

                      Get.to(() => SeyhanList());
                    },
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
                  Divider(color: Colors.white,thickness: 2,),

                  ListTile(
                    leading: Icon(

                      Icons.exit_to_app,color: sinir,size: 30,
                    ) ,
                    title: Text('ÇIKIŞ YAP', style: baslik2),
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((deger) {
                        Get.to(() => Login());
                      });
                    },
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
