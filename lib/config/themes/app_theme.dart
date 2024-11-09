import 'package:flutter/material.dart';
import '/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      buttonTheme: buttonTheme(),
      iconButtonTheme: iconButtonTheme(),
      appBarTheme: appBarTheme(),
      // Màu nền cho toàn bộ scaffold
      scaffoldBackgroundColor: AppColors.whiteColor,
    );
  }

  // AppBar theme
  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
      // Set background color for AppBar
      backgroundColor: AppColors.whiteColor,
      elevation: 4, // Subtle shadow for polished look
      shadowColor: Colors.grey, // Shadow color for the bottom divider effect
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColors.whiteColor, // Text color of the toolbar
      ),
      titleTextStyle: TextStyle(
        color: AppColors.blackColor, // Title text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }


  // Button theme
  static ButtonThemeData buttonTheme() {
    return const ButtonThemeData(
      buttonColor: AppColors.blueColor,
    );
  }

  // Icon Button Theme
  static IconButtonThemeData iconButtonTheme() {
    return const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(
          AppColors.blackColor,
        ),
        backgroundColor: MaterialStatePropertyAll(
          Colors.transparent,
        ),
      ),
    );
  }
}
