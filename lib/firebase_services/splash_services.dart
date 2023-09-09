import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final pref = SharedPreferences.getInstance();
    if (!context.mounted) return;
    Timer(const Duration(seconds: 3), () async {
      final preferene = await pref;
      Navigator.pushNamed(
          context,
          (preferene.getString('email') == null)
              ? MyRoutes.onBoardingRoute
              : MyRoutes.homeRoute);
    });
  }
}
