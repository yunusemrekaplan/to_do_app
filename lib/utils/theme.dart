import 'package:flutter/material.dart';

import 'constants/color.dart';
import 'constants/text_style.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    iconTheme: const IconThemeData(color: ColorConstants.secondaryColor),
    textButtonTheme: TextButtonThemeData(
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontSize: 28,
      ),
      bodyMedium: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        color: ColorConstants.secondaryColor,
        fontFamily: 'Poppins',
      ),
    ),
  );
}
