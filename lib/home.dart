import 'dart:io';
import 'package:adana/auth/login.dart';
import 'package:adana/constants/constants.dart';
import 'package:adana/mesire/ceyhanList.dart';
import 'package:adana/mesire/karaisaliMesire.dart';
import 'package:adana/mesire/seyhanList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'TileScreen.dart';
import 'mesire/cukurovaList.dart';

late User loggedInuser;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirmeBaglantisi;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool getImage = false;

  List types = [
    {
      'ad': "KAPIKAYA KANYONU",
      'image': "assets/karaisali/kanyon/k5.jpg",
      'bilgi': "Kapıkaya Kanyonu, Adana ili Karaisalı ilçesinde "
          "Kapıkaya köyünde bulunan kanyon."
          "Kanyonu Seyhan Nehri'nin kollarından Çakıt'"
          " Deresi açmıştır. Çakıt Deresi, Seyhan Nehri'"
          "nin Batı koludur. Pozantı Boğazından dağlık "
          "alanlara doğru uzanır. Kanyon Varda Köprüsü'ne '"
          "'2 km uzaklığındadır."
          "Kanyon çevresinde bitki örtüsü; zakkum, "
          " zeytin, keçiboynuzu ve çınar ağaçlarından oluşur.",
      'puan': "4",
    },
    {
      'puan': "4",
      'ad': "SABANCI MERKEZ CAMİ", 'image': "assets/merkezcami.jpg",
      'bilgi': "Adana'nın Reşatbey Semti'nde, Merkez Park'ın güneyinde ve Seyhan "
          "Nehri'nin batı kıyısında yer alan cami, 1998 yılında hizmete "
          "açılmıştır. 32 metre çaplı ana kubbesi vardır.",
    },
    {
      'puan': "5",
      'ad': "VARDA KÖPRÜSÜ", 'image': "assets/karaisali/varda/v4.jpg",
      'bilgi': "Varda Köprüsü, Adana ili Karaisalı ilçesi Hacıkırı "
          "(Kıralan) mahallesi'nde bulunan, yöre halkı tarafından Koca "
          "Köprü diye anılan köprü. Hacıkırı Demiryolu"
          " Köprüsü olarak ya da 1912 yılında Almanlar"
          " tarafından inşa edildiği için Alman köprüsü olarak bilinmektedir.",
    },
    {
      'puan': "5",
      'ad': "DOKUZOLUK",
      'image': "assets/karaisali/dokuzoluk/d2.jpg",
      'bilgi': "Dokuzoluk piknik alanı bir kanyonun hemen kenarında çeşitli "
          "noktalardan fışkıran pınarlar, yemyeşil bitki örtüsü ve"
          " ziyaretçilerin buz gibi suyunda serinledikleri göletlerden"
          " oluşmaktadır. Piknik yapmak, yüzmek, balık tutmak,"
          " yürüyüş yapmak, fotoğraf çekmek burada gerçekleştirilebilecek"
          " aktiviteler arasındadır. Köprünün üzerinden kanyon manzarasının "
          "fotoğrafının çekilmesi tavsiye edilir.",
    },
    {
      'puan': "4",
      'ad': "KARAPINAR PARKI", 'image': "assets/karaisali/park/k11.jpg",
      'bilgi': " Karaisalı, Roma Döneminden önemli izler taşıyan"
          " ilçe konumuna sahip olan bir bölgedir. Bu ilçe,"
          " soyunun Ramazanoğulları ve Menemencioğullarından geldiği"
          " günümüzdeki adını"
          " da Ramazanoğullarından Kara İsa Bey’den aldığı bilinen bir husustur.",
    },
  ];

  void getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      setState(() {
        loggedInuser = user;
      });
    }
  }

  void initState() {
    super.initState();
    getCurrentUser();
    baglantiAl();
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
      getImage = true;
    });
  }

  kameradanYukle() async {
    var alinanDosya =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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

  DateTime timeDifference = DateTime.now();

  Future<bool> exitApp() async {
    FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(Login());
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeDifference);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeDifference = DateTime.now();
        if (isExitWarning) {
          final message = "Çıkış Yapmak için artarda 2 kez tıklayın";
          Get.snackbar(
            "Bilgi",
            message,
            backgroundColor: Colors.grey.shade200,
            snackPosition: SnackPosition.BOTTOM,
          );
          return false;
        } else {
          exitApp();
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: kutu,
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: deneme,
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
                                      width: size.width * 3 / 10,
                                      height: size.width * 2 / 7,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      indirmeBaglantisi!,
                                      width: size.width * 3 / 10,
                                      height: size.width * 2 / 7,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loggedInuser.email.toString(),
                        style: cityName,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text('KARAİSALI', style: xdAppBarBaslik),
                    onTap: () {
                      Get.to(() => KaraisaliMesireList());
                    },
                  ),
                  ListTile(
                    title: Text('SEYHAN', style: xdAppBarBaslik),
                    onTap: () {
                      Get.to(() => SeyhanList());
                    },
                  ),
                  ListTile(
                    title: Text('ÇUKUROVA', style: xdAppBarBaslik),
                    onTap: () {
                      Get.to(() => CukurovaList());
                    },
                  ),
                  ListTile(
                    title: Text(
                      'CEYHAN',
                      style: xdAppBarBaslik,
                    ),
                    onTap: () {
                      Get.to(() => CeyhanList());
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: sinir,
                      size: 30,
                    ),
                    title: Text('ÇIKIŞ YAP', style: xdAppBarBaslik),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "POPÜLER MEKANLAR",
                  style: front,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: size.height/1.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: types.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TileScreen(), arguments: [
                          index,
                          types[index]['image'],
                          types[index]['ad'],
                          types[index]['bilgi'],
                          types[index]['puan'],
                        ]);
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Stack(children: [
                          Hero(
                            tag: "target$index",
                            child: Container(
                              width: size.width / 1.4,
                              height: size.height /1.8,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        types[index]['image'],
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          Container(
                            width: size.width / 1.4,
                            height: size.height / 1.8,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.9)
                                    ],
                                    stops: const [
                                      0.4,
                                      0.9
                                    ]),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          Positioned(
                              bottom: size.width/4,
                              left: 50 ,
                              child: Text(
                                types[index]['ad'],
                                style: xdBeyaz,
                              ))
                        ]),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
