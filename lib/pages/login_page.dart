import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:money_tracker/widgets/divider.dart';
import 'package:money_tracker/widgets/main_button.dart';
import 'package:money_tracker/widgets/on_boarding_widgets/info_box.dart';
import '../utils/themes.dart';
import '../widgets/appbar.dart';
import '../widgets/background.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = false;
  bool? dummy;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //Name Field
    var nameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              decoration: giveInputDecoration(
                  hint: 'Enter name',
                  icon: const Icon(CupertinoIcons.person_crop_circle)),
            ),
          ),
        )
      ],
    );
    //Password Field
    var passwordField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              obscureText: !isVisible,
              decoration: giveInputDecorationPassword1(
                hint: 'Enter password',
                icon: const Icon(Icons.lock_outline),
              ),
            ),
          ),
        )
      ],
    );

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
              const Text(
                "mono",
                textScaleFactor: 3,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).animate().slideX(duration: const Duration(milliseconds: 300)),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                  height: screenHeight * 0.33,
                  width: screenWidth,
                  margin: EdgeInsets.all(screenWidth * 0.07),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: FormWidgets.getBoxDecoration(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Name Field
                        nameField,
                        const SizedBox(
                          height: 15,
                        ),
                        //Email Field
                        passwordField,
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (dummy) {}),
                                const Text('Remember me')
                              ],
                            ),
                            const InkWell(
                              child: Text(
                                'Forget password?',
                                style: TextStyle(
                                    color: MyThemes.greenColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ])),
              MainButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  title: 'Login',
                  onTapFunction: () {}),

              Padding(
                padding: EdgeInsets.all(screenWidth * 0.08),
                child: const DividerWithText(text: 'Or continue with'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                          'assets/icons/login_signup/google_icon.png')),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                          'assets/icons/login_signup/facebook_icon.png')),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                          'assets/icons/login_signup/linkedin_icon.png')),
                ],
              ),
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

// Decoration for name and email field.
  InputDecoration giveInputDecoration(
      {required String hint, required Icon icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 15),
      prefixIcon: icon,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: MyThemes.greenColor,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: MyThemes.greenColor,
            width: 1.6,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }

// decorations for password field, separate because of visibility
  InputDecoration giveInputDecorationPassword1(
      {required String hint, required Icon icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 15),
      prefixIcon: icon,
      suffixIcon: GestureDetector(
        onTap: () {
          isVisible = !isVisible;
          setState(() {});
        },
        child: (isVisible)
            ? const Icon(Icons.visibility_outlined)
            : const Icon(Icons.visibility_off_outlined),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: MyThemes.greenColor,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: MyThemes.greenColor,
            width: 1.6,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
