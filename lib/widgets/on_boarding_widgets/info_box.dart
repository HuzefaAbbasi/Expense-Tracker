import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/themes.dart';

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
          GetStartedButton(
              screenHeight: screenHeight, screenWidth: screenWidth),
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

class GetStartedButton extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const GetStartedButton({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: screenHeight * 0.08,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [MyThemes.lightGreenColor, MyThemes.greenColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                  color: MyThemes.greenColorShadow.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(2, 15))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: const Center(
          child: Text(
            "Get Started",
            textScaleFactor: 1.3,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ).animate().slideY().then().shake(),
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
