import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';

class OverScreen extends StatelessWidget {
  OverScreen({super.key});

  static const routeName = '/transaction_book';

  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Logger in over as: ' + user.email!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
