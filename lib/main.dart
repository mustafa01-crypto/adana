import 'package:adana/auth/login.dart';
import 'package:adana/ilceler/ceyhan/anavarza.dart';
import 'package:adana/ilceler/ceyhan/durhasan.dart';
import 'package:adana/ilceler/ceyhan/kurtkulagi.dart';
import 'package:adana/ilceler/ceyhan/tumlu.dart';
import 'package:adana/ilceler/ceyhan/yilanKale.dart';
import 'package:adana/ilceler/cukurova/karatasPlaji.dart';
import 'package:adana/ilceler/cukurova/muzeKompleksi.dart';
import 'package:adana/ilceler/cukurova/sevgiAdasi.dart';
import 'package:adana/ilceler/cukurova/seyhanBaraji.dart';
import 'package:adana/ilceler/karaisali/karapinar.dart';
import 'package:adana/ilceler/pozanti/akca_tekir.dart';
import 'package:adana/ilceler/pozanti/anahca.dart';
import 'package:adana/ilceler/pozanti/anit_agac.dart';
import 'package:adana/ilceler/pozanti/armut_yayla.dart';
import 'package:adana/ilceler/pozanti/seker_pinari.dart';
import 'package:adana/ilceler/pozanti/tabyalar.dart';
import 'package:adana/ilceler/seyhan/ataturkEvi.dart';
import 'package:adana/ilceler/seyhan/bebekliKilisesi.dart';
import 'package:adana/ilceler/seyhan/cobanDedeParki.dart';
import 'package:adana/ilceler/seyhan/saatKulesi.dart';
import 'package:adana/ilceler/seyhan/sabanciMerkezCami.dart';
import 'package:adana/ilceler/seyhan/sinemaM%C3%BCzesi.dart';
import 'package:adana/ilceler/seyhan/tasKopru.dart';
import 'package:adana/ilceler/seyhan/uluCami.dart';
import 'package:adana/ilceler/yumurta/ayas_antik.dart';
import 'package:adana/ilceler/yumurta/kiz_kalesi.dart';
import 'package:adana/ilceler/yumurta/suleyman_kulesi.dart';
import 'package:adana/onBoarding/onBoarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ilceler/cukurova/dogalPark.dart';
import 'ilceler/cukurova/yumurtalikLagunu.dart';
import 'ilceler/karaisali/almankoprusu.dart';
import 'ilceler/karaisali/dokuzoluk.dart';
import 'ilceler/karaisali/kanyon.dart';
import 'ilceler/karaisali/kesireHan.dart';
import 'ilceler/karaisali/kizildagYaylasi.dart';
import 'ilceler/karaisali/yerkopru.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      getPages: [
        //anasayfa
        GetPage(name: '/splash', page: () => Splash()),

        //karaisalı
        GetPage(name: '/dokuzoluk', page: () => Dokuzoluk()),
        GetPage(name: '/kanyon', page: () => Kanyon()),

        GetPage(name: '/varda', page: () => AlmanKoprusu()),
        GetPage(name: '/karapinar', page: () => Karapinar()),
        GetPage(name: '/kesire', page: () => KesireHan()),
        GetPage(name: '/kizildag', page: () => Kizildag()),
        GetPage(name: '/yerkopru', page: () => YerKopru()),
        //Ceyhan

        GetPage(name: '/anavarza', page: () => Anavarza()),
        GetPage(name: '/durhasan', page: () => Durhasan()),
        GetPage(name: '/kurt', page: () => KurtKulagi()),
        GetPage(name: '/tumlu', page: () => Tumlu()),
        GetPage(name: '/yilan', page: () => YilanKale()),

        //cukurova

        GetPage(name: '/dogal', page: () => DogalPark()),
        GetPage(name: '/karatas', page: () => KaratasPlaji()),
        GetPage(name: '/muze', page: () => MuzeKompleksi()),
        GetPage(name: '/sevgi', page: () => SevgiAdasi()),
        GetPage(name: '/baraj', page: () => SeyhanBaraji()),
        GetPage(name: '/lagun', page: () => YumurtalikLagunu()),

        //seyhan

        GetPage(name: '/ataturk', page: () => AtaturkEvi()),
        GetPage(name: '/kilise', page: () => BebekliKilisesi()),
        GetPage(name: '/dede', page: () => CobanDede()),
        GetPage(name: '/saat', page: () => SaatKulesi()),
        GetPage(name: '/merkez', page: () => SabanciMerkezCamii()),
        GetPage(name: '/sinema', page: () => SinemaMuzesi()),
        GetPage(name: '/ulu', page: () => UluCamii()),
        GetPage(name: '/taskopru', page: () => TasKopru()),

        //pozantı

        GetPage(name: '/armut', page: () => ArmutYayla()),
        GetPage(name: '/akca_tekir', page: () => AkcaTekir()),
        GetPage(name: '/tabya', page: () => Tabyalar()),
        GetPage(name: '/anit', page: () => AnitAgaci()),
        GetPage(name: '/anahsa', page: () => Anahsa()),
        GetPage(name: '/seker', page: () => SkerPinari()),

        //YUMURTALIK
        GetPage(name: '/ayas', page: () => AyasAntik()),
        GetPage(name: '/kizkalesi', page: () => KizKalesi()),
        GetPage(name: '/suleyman', page: () => SuleymanKulesi()),
      ],
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Login()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoardingPage()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Yükleniyor'),
      ),
    );
  }
}
