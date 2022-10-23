import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class T1 {

  static ThemeData themeData() {
    return ThemeData(
      // scaffoldBackgroundColor: const Color(0xff292929),
      scaffoldBackgroundColor: const Color(0xff191919),
      primaryColor: const Color(0xffFAFF00),
      canvasColor: const Color(0xffE3D170),
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        caption: GoogleFonts.merriweather(fontWeight: FontWeight.normal, fontSize: 30),
        headline1: GoogleFonts.reemKufi(fontSize: 18),
        headline2: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        headline3: GoogleFonts.ptSerif(fontSize: 16, fontWeight: FontWeight.normal),
        // subtitle1: GoogleFonts.satisfy(fontSize: 30,fontWeight: FontWeight.normal)
      ),
    );
  }
}