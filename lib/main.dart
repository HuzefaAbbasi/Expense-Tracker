import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/pages/login_page.dart';
import 'package:money_tracker/ui/on_boarding.dart';
import 'package:money_tracker/ui/splash_screen.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:money_tracker/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        MyRoutes.loginRoute: (context) => const Login(),
        MyRoutes.onBoardingRoute: (context) => const OnBoarding(),
      },
    );
  }
}
