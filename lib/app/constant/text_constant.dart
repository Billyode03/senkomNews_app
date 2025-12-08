import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senkom_news_app/app/constant/color_constant.dart';

class TextStyleUsable {
  static TextStyle openingLogo = GoogleFonts.orbitron(
    fontSize: 20,
    color: ColorConstant.black,
    letterSpacing: 3,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        offset: Offset(1, 2),
      ),
    ],
  );

  static TextStyle titleBig = GoogleFonts.orbitron(
    fontSize: 15,
    color: ColorConstant.black,
    letterSpacing: 3,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        offset: Offset(1, 2),
      ),
    ],
  );

  static TextStyle title_two = GoogleFonts.poppins(
    fontSize: 10,
    color: ColorConstant.black,
    letterSpacing: 3,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        offset: Offset(1, 2),
      ),
    ],
  );
}
