// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../widgets/on_boarding_widgets/info_box.dart';
import '../widgets/on_boarding_widgets/on_boarding_image.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Column(
        children: [
          const OnBoardingimage(),
          InfoBox(screenHeight: screenHeight, screenWidth: screenWidth)
        ],
      ),
    );
  }
}
