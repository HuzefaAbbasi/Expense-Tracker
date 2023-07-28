import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:money_tracker/utils/themes.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Column(
        children: [
          Expanded(
              child: Image.asset('assets/images/on_boarding.png')
                  .animate()
                  .fadeIn()),
          SizedBox(
            height: screenHeight * 0.3,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Spend Smarter\nSave More",
                  style: TextStyle(
                      color: MyThemes.greenColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              MyThemes.lightGreenColor,
                              MyThemes.greenColor
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        boxShadow: [
                          BoxShadow(
                              color: MyThemes.greenColorShadow.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(2, 15))
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40))),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ).animate().slideY().then().shake(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
