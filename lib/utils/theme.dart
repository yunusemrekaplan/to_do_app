import 'package:flutter/material.dart';

import 'constants/color.dart';
import 'constants/text_style.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstants.backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyleConstants.appBarTitle,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: ColorConstants.secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
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
