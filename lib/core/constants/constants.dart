import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';
import 'package:personal_financial_management/features/add/presentation/screens/add_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/profile_screen.dart';
import 'package:personal_financial_management/features/budget/presentation/screens/budget_screen.dart';
import 'package:personal_financial_management/features/over/presentation/screens/over_screen.dart';
import 'package:personal_financial_management/features/transaction_book/presentation/screens/transaction_book_screen.dart';

class Constants {
  // Default padding for screens
  static const defaultPadding = EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 10,
  );

  // demo profile urls
  static const String maleProfilePic =
      'https://jeremyveldman.com/wp-content/uploads/2019/08/Generic-Profile-Pic.jpg';

  static const String profilePicBlank =
      'https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg';

  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: AppColors.darkGreyColor,
          size: AppSizes.xxLarge,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.book : Icons.book_outlined,
          color: AppColors.darkGreyColor,
          size: AppSizes.xxLarge,
        ),
      ),
      Tab(
        icon: PreferredSize(
          preferredSize: const Size.fromRadius(AppSizes.xxxLarge*2),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: AppSizes.xxxLarge*2,
            child: Icon(
              index == 2 ? Icons.add : Icons.add_outlined,
              color: AppColors.realWhiteColor,
              size: AppSizes.xxxLarge * 0.8,
            ),
          ),
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? Icons.temple_buddhist : Icons.temple_buddhist_outlined,
          color:  AppColors.darkGreyColor,
          size: AppSizes.xxLarge,
        ),
      ),
      Tab(
        icon: Icon(
          index == 4 ? Icons.account_circle : Icons.account_circle_outlined,
          color: AppColors.darkGreyColor,
          size: AppSizes.xxLarge,
        ),
      ),
    ];
  }

  static List<Widget> screens = [
    OverScreen(),
    TransactionBookScreen(),
    AddScreen(),
    BudgetScreen(),
    ProfileScreen()
  ];

  Constants._();
}
