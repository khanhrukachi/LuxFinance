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
      // Đặt màu nền cho AppBar
      backgroundColor: AppColors.blackColor,
      elevation: 0,
      iconTheme: IconThemeData(
        // Màu của các biểu tượng trong AppBar
        color: AppColors.whiteColor,
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
