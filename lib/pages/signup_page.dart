import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:money_tracker/utils/themes.dart';
import 'package:money_tracker/widgets/main_button.dart';
import 'package:money_tracker/widgets/signup_widgets/background.dart';
import 'package:money_tracker/widgets/signup_widgets/form.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //App Bar
    var appBar2 = AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        "Sign up",
      ),
      centerTitle: true,
      elevation: 0,
    );
    //Box Decoration of Form

    return Scaffold(
      //it makes body go behind app bar
      extendBodyBehindAppBar: true,
      appBar: appBar2,
      body: Stack(
        children: [
          Background(screenWidth: screenWidth, screenHeight: screenHeight),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.2,
                ),
                const SignupForm(),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                MainButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  title: 'Sign up',
                  onTapFunction: () =>
                      Navigator.pushNamed(context, MyRoutes.loginRoute),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
