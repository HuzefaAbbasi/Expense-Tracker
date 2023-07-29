// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/themes.dart';

class MainButton extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String title;
  final VoidCallback onTapFunction;
  const MainButton({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.title,
    required this.onTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
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
        child: Center(
          child: Text(
            title,
            textScaleFactor: 1.3,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ).animate().slideY().then().shake(),
    );
  }
}
