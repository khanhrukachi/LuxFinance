import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';
import 'package:personal_financial_management/core/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    // Update the tab index and animate to the selected tab
    _tabController.index = index; // Prevents swiping
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: _buildFacebookText(),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures
        children: Constants.screens,
      ),
      bottomNavigationBar: Container(
        color: AppColors.whiteColor,
        child: TabBar(
          tabs: Constants.getHomeScreenTabs(_tabController.index),
          controller: _tabController,
          onTap: _onTabChanged, // Handle tab changes here
          indicator: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.transparent,
                width: 3.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFacebookText() => const Text(
    'LuxFinance',
    style: TextStyle(
      color: AppColors.blackColor,
      fontSize: AppSizes.xLarge,
      fontWeight: FontWeight.bold,
    ),
  );
}
