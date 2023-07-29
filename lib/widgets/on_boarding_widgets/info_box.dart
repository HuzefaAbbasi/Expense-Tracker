// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/routes.dart';
import '../../utils/themes.dart';
import '../main_button.dart';

class InfoBox extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const InfoBox({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.3,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const OnBoardingTitle(),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            title: 'Get Started',
            onTapFunction: () =>
                Navigator.pushNamed(context, MyRoutes.signupRoute),
          ),
          const SizedBox(
            height: 20,
          ),
          const AlreadyAccountRow(),
        ],
      ),
    );
  }
}

class OnBoardingTitle extends StatelessWidget {
  const OnBoardingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Spend Smarter\nSave More",
      style: TextStyle(color: MyThemes.greenColor, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      textScaleFactor: 2,
    );
  }
}

class AlreadyAccountRow extends StatelessWidget {
  const AlreadyAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have Account?",
          textScaleFactor: 1.1,
          style: TextStyle(color: MyThemes.textColor),
        ),
        InkWell(
            child: Text(
          "  Log in",
          textScaleFactor: 1.1,
          style: TextStyle(color: MyThemes.greenColor),
        ))
      ],
    );
  }
}
