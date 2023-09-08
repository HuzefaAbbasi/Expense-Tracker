import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/pages/add-transaction_page.dart';
import 'package:money_tracker/pages/home_page.dart';
import 'package:money_tracker/pages/login_page.dart';
import 'package:money_tracker/pages/signup_page.dart';
import 'package:money_tracker/pages/transactions_page.dart';
import 'package:money_tracker/ui/on_boarding.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:money_tracker/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: MyThemes.greenColor,
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        MyRoutes.loginRoute: (context) => const Login(),
        MyRoutes.onBoardingRoute: (context) => const OnBoarding(),
        MyRoutes.signupRoute: (context) => const Signup(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.transactionsRoute: (context) => const Transactions(),
        MyRoutes.addTransactionsRoute: (context) => const AddTransaction(),
      },
    );
  }
}
