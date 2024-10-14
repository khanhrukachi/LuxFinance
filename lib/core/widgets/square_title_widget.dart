import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';

class SquareTitleWidget extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const SquareTitleWidget({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.large),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(AppSizes.medium),
          color: AppColors.whiteColor,
        ),
        child: Image.asset(
          imagePath,
          height: 43,
          width: 43,
        ),
      ),
    );
  }
}
