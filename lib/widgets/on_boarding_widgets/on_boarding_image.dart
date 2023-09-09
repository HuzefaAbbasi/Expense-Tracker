import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnBoardingimage extends StatelessWidget {
  const OnBoardingimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Image.asset('assets/images/on_boarding.png')
            .animate()
            .moveY(duration: const Duration(milliseconds: 800)));
  }
}
