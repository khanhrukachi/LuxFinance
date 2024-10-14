import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_fontSizes.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.xLarge),
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.xLarge),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(AppSizes.xSmall),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: AppFontSizes.medium,
            ),
          ),
        ),
      ),
    );
  }
}
