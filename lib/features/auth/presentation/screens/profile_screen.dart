import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/screens/home_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const routeName = '/profile';

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen after sign out
      print('User successfully signed out.');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Function to fetch the user's full name from Firestore
  Future<String> getFullName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Assuming the collection name is 'users'
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc['fullName'] ?? 'No full name available';
      } else {
        return 'No full name available';
      }
    } catch (e) {
      return 'Error retrieving full name';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: const Icon(
              Icons.logout,
              color: AppColors.realWhiteColor,
            ),
          )
        ],
      ),
      body: FutureBuilder<String>(
        future: getFullName(), // Fetch full name
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error handling
          } else {
            // Once data is fetched, display the full name and email
            return Center(
              child: Text(
                'Logged in as: ${snapshot.data}\nEmail: ${user.email!}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
