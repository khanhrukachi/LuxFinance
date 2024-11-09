import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/core/screens/loading_screen.dart';
import 'package:personal_financial_management/core/utils/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<void> signInWithApple(BuildContext context) async {
  // Show loading screen
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const LoadingScreen();
    },
  );

  try {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.example.personal_financial_management',
        redirectUri: Uri.parse('https://luxfinance-93617.firebaseapp.com/__/auth/handler'),
      ),
    );

    final credential = OAuthProvider("apple.com").credential(
      accessToken: appleCredential.authorizationCode,
      idToken: appleCredential.identityToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pop(context);
  } catch (e) {
    Navigator.pop(context);
    wrongMessage('Apple Sign-In failed. Please try again.', context);
  }
}