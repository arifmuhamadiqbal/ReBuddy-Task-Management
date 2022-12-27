import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xDD4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xDDdd4667);
const Color white = Colors.white;
const primaryClr = yellowClr;
const Color darkGreyClr = Color(0xDD121212);
Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: Colors.amber,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
  );
}

TextStyle get HeadingStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400]: Colors.grey,
      )
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white: Colors.black,
    )
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white: Colors.black,
      )
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[100]: Colors.grey[600],
      )
  );
}