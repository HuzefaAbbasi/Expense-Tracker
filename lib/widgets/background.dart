// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const Background({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: screenHeight * 0.35,
      width: screenWidth,
      top: 0,
      child: Image.asset(
        'assets/images/background.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
