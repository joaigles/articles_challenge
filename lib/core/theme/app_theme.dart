import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    secondaryHeaderColor: lightContainerArticle,
    scaffoldBackgroundColor: primary,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: darkPrimary,
    secondaryHeaderColor: darkContainerArticle,
    scaffoldBackgroundColor: darkPrimary,
  );

  static TextStyle articleTitleStyle = GoogleFonts.poppins(
    color: articleTitle,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );

  static TextStyle carouselTitle = GoogleFonts.poppins(
    color: articleTitle,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );

  static TextStyle articleDescriptionStyle = GoogleFonts.poppins(
    color: articleDescription,
  );
  static TextStyle appBarTitleStyle = GoogleFonts.poppins(
    color: primary,
  );

  static const Color primary = Color.fromRGBO(230, 230, 230, 1);
  static const Color darkPrimary = Color.fromRGBO(20, 18, 24, 1);
  static const Color lightContainerArticle = Color.fromRGBO(255, 255, 255, 1);
  static const Color darkContainerArticle = Color.fromRGBO(0, 0, 0, 1);
  static const Color appbarBackground = Color.fromRGBO(27, 20, 100, 1);
  static const Color articleTitle = Color.fromRGBO(128, 123, 163, 1);
  static const Color articleDescription = Color.fromRGBO(141, 141, 141, 1);
}
