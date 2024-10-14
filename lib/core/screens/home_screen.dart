import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = '/home';

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              color: AppColors.realWhiteColor,
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          'Logger in as: ' + user.email!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
