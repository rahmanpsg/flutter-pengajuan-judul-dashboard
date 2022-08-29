import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

ThemeData appTheme = ThemeData(
  primaryColor: mainColor,
  scaffoldBackgroundColor: backgroundColor,
  canvasColor: backgroundColor,
  fontFamily: 'YanoneKaffeesatz',
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: fontColor),
    elevation: 0,
    titleTextStyle: mediumTextStyle.copyWith(fontSize: 24),
    centerTitle: false,
  ),
  textTheme: TextTheme(
    headline1: regularTextStyle.copyWith(fontSize: 32),
    headline2: regularTextStyle.copyWith(fontSize: 20),
    headline3: regularTextStyle.copyWith(fontSize: 18),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: mainColor,
      onSurface: mainColor,
      elevation: 0,
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      textStyle: boldTextStyle.copyWith(fontSize: 16),
      shadowColor: Colors.transparent,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: boldTextStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      side: const BorderSide(
        color: secondaryColor,
        width: 1,
      ),
      primary: secondaryColor,
      onSurface: mainColor,
      minimumSize: const Size(double.infinity, 60),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: mainColor,
      onSurface: mainColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      textStyle: semiBoldTextStyle,
      shadowColor: Colors.transparent,
    ),
  ),
  iconTheme: const IconThemeData(
    color: mainColor,
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(mainColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: const BorderSide(
      color: mainGreyColor,
      width: 1,
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(mainGreyColor),
  ),
);