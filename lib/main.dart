import 'package:flutter/material.dart';
import 'package:personal_financial_management/config/routers/routes.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/auth_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
