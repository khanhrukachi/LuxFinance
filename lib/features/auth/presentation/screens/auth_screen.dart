import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/screens/home_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/login_or_create_account_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          else {
            return LoginOrCreateAccountScreen();
          }
        },
      ),
    );
  }
}
