import 'package:adana/auth/login.dart';
import 'package:adana/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.to(()=> Login());
  }


  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: kutu,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('github/sifir.png', 50),
          ),
        ),
      ),
      /*
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,

        child: ElevatedButton(

          child: const Text(
            'Hadi Başlayalım',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
       */
      pages: [
        PageViewModel(
          title: "Gez Gör Keşfet",
          body:
          "Güzide ilimizde bulunan tarihi ve doğal güzellikleri keşfedin",
          image: _buildImage('seyhan/merkezcami.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Yorum Yap",
          body:
          "Gezdiğiniz yerler hakkında yorum yapın.",
          image: _buildImage('github/yorum.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tek tuşla istediğiniz mekana gidin",
          body:
          "Uygulumamızdaki harita özelliği sayesinde uygulamamızda bulunan yerlere tek tıkla gidebilirsiniz.",
          image: _buildImage('github/map.jpeg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),

      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,

      skip: const Text('Geç'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Bitti', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator:  ShapeDecoration(
        color: sinir,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
