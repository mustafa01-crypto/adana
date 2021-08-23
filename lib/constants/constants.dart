import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle cityName =
    TextStyle(color: sinir, fontSize: 18, fontWeight: FontWeight.w500);

TextStyle butonBaslik =
    TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700);

Color sinir = Color(0xFFFF6701);
Color scaffold = Color(0xFFFC7925);
Color scaffold2 = Color(0xFFFBFAFE);

Color kutu = Color(0xFFEBE9FA);
Color kutu2 = Color(0xFFc5bdfb);
Color kutu3 = Color(0xFF958bdd);

Gradient gradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.white,
    scaffold,
  ],
);
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
    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22

);