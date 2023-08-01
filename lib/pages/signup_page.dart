import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:money_tracker/widgets/appbar.dart';
import 'package:money_tracker/widgets/main_button.dart';
import 'package:money_tracker/widgets/background.dart';
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

    return Scaffold(
      //it makes body go behind app bar
      extendBodyBehindAppBar: true,
      appBar: FormWidgets.getAppBar('Sign up'),
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
