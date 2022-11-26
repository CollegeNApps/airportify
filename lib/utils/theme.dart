import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class T1 {
  static ThemeData themeData() {
    return ThemeData(
      // scaffoldBackgroundColor: const Color(0xff292929),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xffFFDB29),
      canvasColor: Colors.black,
      // primarySwatch: Colors.amber,
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        caption: GoogleFonts.merriweather(fontWeight: FontWeight.normal, fontSize: 15),
        headline1: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
        headline2: GoogleFonts.ptSerif(fontSize: 16, fontWeight: FontWeight.normal),
        // subtitle1: GoogleFonts.satisfy(fontSize: 30,fontWeight: FontWeight.normal)
      ),
    );
  }
}
