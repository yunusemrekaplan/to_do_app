import 'package:flutter/material.dart';

import 'constants/color.dart';
import 'constants/text_style.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorConstant.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstant.backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyleConstant.appBarTitle,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: ColorConstant.secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          ColorConstant.primaryColor,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          ColorConstant.secondaryColor,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyleConstant.textFieldLabel,
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: ColorConstant.secondaryColor, width: 1.5),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 48),
        ),
      ),
    ),
    /*textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          ColorConstants.primaryColor,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          ColorConstants.secondaryColor,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyleConstants.textFieldLabel,
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: ColorConstants.secondaryColor, width: 1.5),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 48),
        ),
      ),
    ), */
  );
}
