import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

TextStyle cityName =
    TextStyle(color: sinir, fontSize: 18, fontWeight: FontWeight.w500);

TextStyle butonBaslik =
    TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700);

Color sinir = Color(0xFFFF6701);
Color scaffold = Color(0xFFFC7925);
Color scaffold2 = Color(0xFFFBFAFE);

TextStyle email = GoogleFonts.sourceSansPro(
    color: Colors.black, fontWeight: FontWeight.w900, fontSize: 14);

TextStyle icerik = GoogleFonts.sourceSansPro(
    color: Colors.grey.shade800, fontWeight: FontWeight.w700, fontSize: 16);
TextStyle icerik2 = GoogleFonts.sourceSansPro(
    color: sinir, fontWeight: FontWeight.w500, fontSize: 18);

Gradient gradient2 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.white,
    scaffold,
  ],
);

TextStyle link = TextStyle(
    color: Colors.indigo,
    fontSize: 24,
    fontWeight: FontWeight.w900,
    decoration: TextDecoration.underline);

Gradient deneme = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.white,
    kutu2,
  ],
);

//XD
Color xdArka = Color(0xFFE6D3EA);
Color sol = Color(0xFFE38ED4);
Color orta = Color(0xFFDCB5D5);
Color sag = Color(0xFFFFFFFF);

Gradient xdGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    sol,
    orta,
    sag,
  ],
);

TextStyle xdAppBarBaslik =
    GoogleFonts.roboto(color: sinir, fontWeight: FontWeight.w500, fontSize: 22);

TextStyle xdUzunYazi =
    GoogleFonts.roboto(color: sinir, fontWeight: FontWeight.w500, fontSize: 18);
TextStyle xdBeyaz = GoogleFonts.roboto(
    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18);
TextStyle xdBeyazBaslik = GoogleFonts.roboto(
    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24);

TextStyle front = GoogleFonts.sourceSansPro(
    color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22);

TextStyle front2 = GoogleFonts.sourceSansPro(
    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22);

Color kutu = Color(0xFFEBE9FA);
Color kutu2 = Color(0xFFE1DEF6);
Color kutu3 = Color(0xFF9C92DF);
Color baslik = Color(0xFF080808);
Color metinColor = Color(0xFF070707);
Color yorumColor = Color(0xFF3A3333);
Color mailColor = Color(0xFF000000);


Color topBack = Color(0xFF261A80);
Color centerBack = Color(0xFF7700FF);
Color bottomBack = Color(0xFF1C00D5);

Color buttonTopGradient = Color(0xFFE1DEF6);
Color buttonBottomGradient = Color(0xFF7700FF);

Gradient buttonBoxGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    buttonTopGradient,
    buttonBottomGradient,
  ],
);

Gradient boxGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    kutu2,
    kutu3,
  ],
);

TextStyle appBarMetin = GoogleFonts.roboto(
  color: baslik,
  fontWeight: FontWeight.bold,
  fontSize: 29,
);

TextStyle metin = GoogleFonts.roboto(
  fontStyle: FontStyle.normal,
  color: metinColor,
  fontWeight: FontWeight.normal,
  fontSize: 22,
);
TextStyle yorumText = GoogleFonts.roboto(
  fontStyle: FontStyle.normal,
  color: yorumColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
);
TextStyle emailText = GoogleFonts.roboto(
  color: mailColor,
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

TextStyle tileMetin = GoogleFonts.roboto(
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontSize: 19,
);

TextStyle loginTitle = GoogleFonts.roboto(
  color: kutu,
  fontWeight: FontWeight.bold,
  fontSize: 30.sp,
);

TextStyle loginButton = GoogleFonts.roboto(
  color: kutu,
  fontWeight: FontWeight.bold,
  fontSize: 31,
);

TextStyle loginText = GoogleFonts.roboto(
  color: kutu,
  fontWeight: FontWeight.normal,
  fontSize: 16.sp,
);

TextStyle loginTextUnderlined = GoogleFonts.roboto(
  decoration: TextDecoration.underline,
  color: kutu,
  fontWeight: FontWeight.normal,
  fontSize: 18.sp,
);