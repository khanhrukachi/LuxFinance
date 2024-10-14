import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';

class MyTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.xLarge),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.realWhiteColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkLightGreyColor),
          ),
          fillColor: AppColors.whiteColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.darkLightGreyColor,),
        ),
      ),
    );
  }
}
