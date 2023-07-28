import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, MyRoutes.onBoardingRoute));
  }
}
