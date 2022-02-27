import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color lightTextColor = const Color(0xff25282b);
  static Color darkTextColor = Colors.white;
  static Color greyTextColor = const Color(0xff524e51);

  static ThemeData theme = lightTheme;
  static Color darkColorSaved = const Color(0xff2A2B2E);

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xffe11a38),
    primaryColorDark: CupertinoColors.black,
    canvasColor: Colors.transparent,
    backgroundColor: darkTextColor,
    unselectedWidgetColor: Color(0xffe8e8e8),
    hintColor: const Color(0xffcacccf),
    appBarTheme: AppBarTheme(elevation: 6),
    shadowColor: const Color(0xfff6f6f6),
    textTheme: const TextTheme().copyWith(
      headline6: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      )),
      headline5: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      )),
      headline4: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      )),
      headline3: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      )),
      headline2: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      )),
      headline1: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      )),
      bodyText1: GoogleFonts.roboto(
          textStyle: TextStyle(
        height: 1.4,
        color: lightTextColor,
        fontSize: 14,
      )),
      bodyText2: GoogleFonts.roboto(
          textStyle: TextStyle(
        height: 1.4,
        color: greyTextColor,
        fontSize: 12,
      )),
      button: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: lightTextColor,
        height: 1.4,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      )),
    ),
  );
}
