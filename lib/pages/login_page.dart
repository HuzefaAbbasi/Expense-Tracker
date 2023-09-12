import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:money_tracker/widgets/divider.dart';
import 'package:money_tracker/widgets/loginwidgets/icon_rows.dart';
import 'package:money_tracker/widgets/loginwidgets/login_form.dart';
import 'package:money_tracker/widgets/on_boarding_widgets/info_box.dart';
import '../widgets/appbar.dart';
import '../widgets/background.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? dummy;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    var appName = const Text(
      "mono",
      textScaleFactor: 3,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ).animate().slideX(duration: const Duration(milliseconds: 300));

    return Scaffold(
      //it makes body go behind app bar
      extendBodyBehindAppBar: true,
      appBar: FormWidgets.getAppBar('Login'),
      body: Stack(children: [
        Background(screenWidth: screenWidth, screenHeight: screenHeight),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.175,
              ),
              //App name
              appName,
              SizedBox(
                height: screenHeight * 0.05,
              ),
              LoginForm(screenWidth: screenWidth, screenHeight: screenHeight),

              //Divider
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.08),
                child: const DividerWithText(text: 'Or continue with'),
              ),
              //Row having social icons
              const IconRow(),
              SizedBox(
                height: screenHeight * 0.023,
              ),
              const AlreadyAccountRow(
                  mainText: 'Dont have account?', clickAbleText: '  Sign up')
            ],
          ),
        )
      ]),
    );
  }
}
