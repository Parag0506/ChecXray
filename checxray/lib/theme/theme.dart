import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color/light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    cardColor: Colors.white,
    primarySwatch: Colors.blue,
    backgroundColor: LightColor.background,
    primaryColor: LightColor.purple,
    accentColor: LightColor.lightblack,
    primaryColorDark: LightColor.Darker,
    primaryColorLight: LightColor.brighter,
    cardTheme: CardTheme(color: LightColor.background),
    textTheme: TextTheme(
        headline4:
            GoogleFonts.cabin(textStyle: TextStyle(color: LightColor.black))),
    iconTheme: IconThemeData(color: LightColor.lightblack),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    colorScheme: ColorScheme(
        primary: LightColor.purple,
        primaryVariant: LightColor.purple,
        secondary: LightColor.darkBlue,
        secondaryVariant: LightColor.darkBlue,
        surface: LightColor.background,
        background: LightColor.background,
        error: Colors.red,
        onPrimary: LightColor.Darker,
        onSecondary: LightColor.background,
        onSurface: LightColor.Darker,
        onBackground: LightColor.titleTextColor,
        onError: LightColor.titleTextColor,
        brightness: Brightness.dark),
  );

  static ThemeData darkTheme = ThemeData(
    cardColor: Colors.black54,
    primarySwatch: Colors.blue,
    backgroundColor: LightColor.darkBlue,
    primaryColor: LightColor.purple,
    accentColor: LightColor.lightblack,
    primaryColorDark: LightColor.Darker,
    primaryColorLight: LightColor.brighter,
    cardTheme: CardTheme(color: LightColor.background),
    textTheme: TextTheme(
        headline4:
            GoogleFonts.cabin(textStyle: TextStyle(color: LightColor.black))),
    iconTheme: IconThemeData(color: LightColor.lightblack),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    colorScheme: ColorScheme(
        primary: LightColor.purple,
        primaryVariant: LightColor.purple,
        secondary: LightColor.background,
        secondaryVariant: LightColor.darkBlue,
        surface: LightColor.background,
        background: LightColor.darkBlue,
        error: Colors.red,
        onPrimary: LightColor.Darker,
        onSecondary: LightColor.darkBlue,
        onSurface: LightColor.Darker,
        onBackground: LightColor.titleTextColor,
        onError: LightColor.titleTextColor,
        brightness: Brightness.dark),
  );

  static TextStyle titleStyle = GoogleFonts.cabin(
      textStyle: TextStyle(color: LightColor.lightblack, fontSize: 16));
  static TextStyle subTitleStyle = GoogleFonts.cabin(
      textStyle: TextStyle(color: LightColor.subTitleTextColor, fontSize: 12));

  static TextStyle h1Style = GoogleFonts.cabin(
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  static TextStyle h2Style =
      GoogleFonts.cabin(textStyle: TextStyle(fontSize: 22));
  static TextStyle h3Style =
      GoogleFonts.cabin(textStyle: TextStyle(fontSize: 20));
  static TextStyle h4Style =
      GoogleFonts.cabin(textStyle: TextStyle(fontSize: 18));
  static TextStyle h5Style =
      GoogleFonts.cabin(textStyle: TextStyle(fontSize: 16));
  static TextStyle h6Style =
      GoogleFonts.cabin(textStyle: TextStyle(fontSize: 14));
}
