import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_financial_management/core/screens/loading_screen.dart';
import 'package:personal_financial_management/core/utils/utils.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const LoadingScreen();
    },
  );

  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      Navigator.pop(context);
      wrongMessage('Google Sign-In failed. Please try again.', context);
      return;
    }

    Navigator.pop(context);

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.email == googleUser.email) {
      if (!currentUser.providerData.any((provider) => provider.providerId == 'google.com')) {
        await currentUser.linkWithCredential(googleCredential);
        wrongMessage('Google account linked successfully.', context);
      } else {
        wrongMessage('Google account already linked.', context);
      }
    } else {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(googleCredential);

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': googleUser.displayName ?? '',
        'email': googleUser.email,
        'profilePicUrl': googleUser.photoUrl ?? '',
      }, SetOptions(merge: true));
    }

  } catch (e) {
    Navigator.pop(context);
    wrongMessage('Google Sign-In failed. Please try again.', context);
  }
}
