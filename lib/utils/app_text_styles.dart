import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // header
  static TextStyle h1 = GoogleFonts.fredoka(color: Colors.white,
      fontSize: 24, fontWeight: FontWeight.w500);

  //body
  static TextStyle bodyLarge = GoogleFonts.fredoka(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMedium = GoogleFonts.fredoka(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // button Text

  static TextStyle buttonLarge = GoogleFonts.fredoka(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white
  );
  static TextStyle buttonMedium = GoogleFonts.fredoka(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // helper

  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
}
