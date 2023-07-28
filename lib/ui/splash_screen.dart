import 'package:flutter/material.dart';
import 'package:money_tracker/firebase_services/splash_services.dart';
import 'package:money_tracker/utils/themes.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyThemes.lightGreenColor, MyThemes.greenColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Center(
            child: const Text(
              "mono",
              textScaleFactor: 3,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ).animate().slideX(duration: const Duration(milliseconds: 300)),
          )),
    );
  }
}
