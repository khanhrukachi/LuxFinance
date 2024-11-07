import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/firebase_collection_names.dart';
import 'package:personal_financial_management/core/utils/utils.dart';
import 'package:personal_financial_management/features/auth/models/user.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Sign in
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // Sign out
  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Create account without Firebase Storage
  Future<UserCredential?> createAccount({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // Create an account in Firebase
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if user is null
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("User not found");
      }

      // Create UserModel without profilePicUrl
      UserModel user = UserModel(
        fullName: fullName,
        email: email,
        password: password,
        uid: currentUser.uid,
        profilePicUrl: '',
      );

      // Save user to Firestore
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(currentUser.uid)
          .set(user.toMap());

      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // Verify Email
  Future<String?> verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await user.sendEmailVerification();
      }
      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  // Get user info
  Future<UserModel> getUserInfo() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("User not found");
      }

      final userData = await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(currentUser.uid)
          .get();

      if (!userData.exists) {
        throw Exception("User data not found");
      }

      final user = UserModel.fromMap(userData.data()!);
      return user;
    } catch (e) {
      showToastMessage(text: e.toString());
      rethrow;
    }
  }
}
