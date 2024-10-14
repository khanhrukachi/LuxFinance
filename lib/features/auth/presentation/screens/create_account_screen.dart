import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_image.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';
import 'package:personal_financial_management/core/screens/loading_screen.dart';
import 'package:personal_financial_management/core/widgets/my_button_widget.dart';
import 'package:personal_financial_management/core/widgets/my_textfield_widget.dart';
import 'package:personal_financial_management/core/widgets/square_title_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  final Function()? onTap;
  const CreateAccountScreen({super.key, required this.onTap});

  static const routeName = '/create-account';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  Future<void> signUserUp() async {
    // Hiển thị màn hình Loading
    showDialog(
      context: context,
      builder: (context) {
        return const LoadingScreen();
      },
    );

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (!isValidEmail(email)) {
      Navigator.pop(context); // Đóng Loading nếu email không hợp lệ
      wrongMessage('Emails are not formatted correctly!');
      return;
    }

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        wrongMessage("Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongMessage('Firebase Error: ${e.message}');
    } catch (e) {
      Navigator.pop(context);
      wrongMessage('An unexpected error occurred. Please try again later!');
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
                      const SizedBox(height: 25),
                      const Icon(
                        Icons.lock,
                        size: 73,
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Let\'s create an account for you!',
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
                      MyTextFieldWidget(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
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
                        onTap: signUserUp,
                        text: 'Sign Up',
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTitleWidget(
                            imagePath: AppImages.logoGoogle,
                          ),
                          SizedBox(width: 25),
                          SquareTitleWidget(
                            imagePath: AppImages.logoApple,
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Login now',
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
