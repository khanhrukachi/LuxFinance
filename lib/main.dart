import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_financial_management/config/routers/routes.dart';
import 'package:personal_financial_management/core/screens/loading_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/login_or_create_account_screen.dart';

import '/config/themes/app_theme.dart';
import '/core/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme(),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }

          if (snapshot.hasData) {
            final user = snapshot.data;
            if (user!.emailVerified) {
              return const HomeScreen();
            } else {
              return const EmailVerificationScreen();
            }
          }

          return  const LoginOrCreateAccountScreen();
        },
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
