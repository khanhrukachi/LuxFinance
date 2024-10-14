import 'package:flutter/material.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/create_account_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/login_screen.dart';

class LoginOrCreateAccountScreen extends StatefulWidget {
  const LoginOrCreateAccountScreen ({super.key});

  @override
  State<StatefulWidget> createState() => _LoginOrCreateAccountScreenState();
}

class _LoginOrCreateAccountScreenState extends State<LoginOrCreateAccountScreen> {
  bool showLoginScreen = true;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;

    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onTap: toggleScreen,
      );
    } else {
      return CreateAccountScreen(
        onTap: toggleScreen,
      );
    }
  }
}