import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';

class BudgetScreen extends StatelessWidget {
  BudgetScreen({super.key});

  static const routeName = '/budget';

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Logger in budget as: ' + user.email!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
