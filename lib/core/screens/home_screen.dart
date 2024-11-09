import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;

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
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Constants.screens[_currentIndex],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        color: AppColors.whiteColor,
        child: Container(
          height: 65,
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
          ),
          child: TabBar(
            tabs: Constants.getHomeScreenTabs(_currentIndex),
            controller: _tabController,
            onTap: _onTabChanged,
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            indicatorPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
