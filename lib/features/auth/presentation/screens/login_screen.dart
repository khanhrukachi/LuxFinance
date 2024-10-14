import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_image.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';
import 'package:personal_financial_management/core/screens/loading_screen.dart';
import 'package:personal_financial_management/core/widgets/my_button_widget.dart';
import 'package:personal_financial_management/core/widgets/my_textfield_widget.dart';
import 'package:personal_financial_management/core/widgets/square_title_widget.dart';
import 'package:personal_financial_management/features/auth/providers/AuthService.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  Future<void> signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const LoadingScreen();
      },
    );

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (!isValidEmail(email)) {
      Navigator.pop(context);
      wrongMessage('Emails are not formatted correctly!');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
    } on FirebaseAuthException {
      Navigator.pop(context);
      wrongMessage('Your account is incorrect!');
    } catch (e) {
      Navigator.pop(context);
      wrongMessage('An unexpected error occurred. Please try again later!');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Show loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const LoadingScreen();
      },
    );
    try {
      await AuthService().SignInWithGoogle();
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
      wrongMessage('Google Sign-In failed. Please try again.');
      print("Error signing in with Google: $e");
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    // Hiển thị màn hình loading
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
          clientId: 'com.example.personalFinancialManagement',
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
      wrongMessage('Apple Sign-In failed. Please try again.');
      print("Error signing in with Apple: $e");
    }
  }


  // Adjusted message functions
  void wrongMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: AppSizes.medium,
          color: AppColors.whiteColor,
        ),
      ),
      backgroundColor: AppColors.redColor,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.greyColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const Icon(
                        Icons.lock,
                        size: 100,
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'Welcome back, you\'ve been missed!',
                        style: TextStyle(
                          color: AppColors.darkGreyColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextFieldWidget(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      MyTextFieldWidget(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: AppSizes.xLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(color: AppColors.darkGreyColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyButton(
                        onTap: signUserIn,
                        text: 'Sign In',
                      ),
                      const SizedBox(height: 50),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: AppSizes.xLarge),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 5,
                                color: AppColors.darkRealLightGreyColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.xxSmall),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(
                                  color: AppColors.darkGreyColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 5,
                                color: AppColors.darkRealLightGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTitleWidget(
                            onTap: () => signInWithGoogle(context),
                            imagePath: AppImages.logoGoogle,
                          ),
                          const SizedBox(width: 25),
                          SquareTitleWidget(
                            onTap: () => signInWithApple(context),
                            imagePath: AppImages.logoApple,
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not a member?'),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 50),
                      // Add spacing for a cleaner look
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
