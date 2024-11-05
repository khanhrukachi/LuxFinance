import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';

class TransactionBookScreen extends StatelessWidget {
  TransactionBookScreen({super.key});

  static const routeName = '/transaction_book';

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
          'Logger in transaction book as: ' + user.email!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
