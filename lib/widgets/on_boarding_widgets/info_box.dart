// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
          const AlreadyAccountRow(
            mainText: "Already have Account?",
            clickAbleText: "  Log in",
          ),
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
  final String mainText;
  final String clickAbleText;
  const AlreadyAccountRow({
    Key? key,
    required this.mainText,
    required this.clickAbleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          textScaleFactor: 1.1,
          style: const TextStyle(color: MyThemes.textColor),
        ),
        InkWell(
            child: Text(
          clickAbleText,
          textScaleFactor: 1.1,
          style: const TextStyle(color: MyThemes.greenColor),
        ))
      ],
    );
  }
}
