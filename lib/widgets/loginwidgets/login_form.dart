// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:money_tracker/utils/toast.dart';
import 'package:money_tracker/widgets/loginwidgets/remember_me.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/themes.dart';
import '../appbar.dart';
import '../main_button.dart';

class LoginForm extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const LoginForm({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final sharedPreferences = SharedPreferences.getInstance();
    moveToHome(BuildContext context) async {
      if (_formKey.currentState!.validate()) {
        try {
          await _auth.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

          final prefs = await sharedPreferences;
          prefs.setString('email', _emailController.text);
          MyToast.makeToast('Logged in successfully');
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, MyRoutes.homeRoute);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            MyToast.makeToast('Invalid Password');
          } else if (e.code == 'user-not-found') {
            MyToast.makeToast('User not found');
          } else {
            MyToast.makeToast('Login Failed ${e.code}');
          }
        } catch (e) {
          MyToast.makeToast('Some error occured $e');
        }
      }
    }

//Email Field
    var nameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: widget.screenHeight * 0.06,
            child: TextFormField(
              controller: _emailController,
              decoration: giveInputDecoration(
                  hint: 'Enter email', icon: const Icon(CupertinoIcons.at)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
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
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: widget.screenHeight * 0.06,
            child: TextFormField(
                controller: _passwordController,
                obscureText: !isVisible,
                decoration: giveInputDecorationPassword1(
                  hint: 'Enter password',
                  icon: const Icon(Icons.lock_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 8) {
                    return 'Password should be atleast 8 characters long';
                  }
                  return null;
                }),
          ),
        )
      ],
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
              height: widget.screenHeight * 0.35,
              width: widget.screenWidth,
              margin: EdgeInsets.all(widget.screenWidth * 0.07),
              padding: EdgeInsets.all(widget.screenWidth * 0.05),
              decoration: FormWidgets.getBoxDecoration(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Name Field
                    nameField,
                    SizedBox(
                      height: widget.screenHeight * 0.02,
                    ),
                    //Email Field
                    passwordField,
                    SizedBox(
                      height: widget.screenHeight * 0.02,
                    ),
                    const RemeberMeRow(),
                  ])),
          MainButton(
            screenHeight: widget.screenHeight,
            screenWidth: widget.screenWidth,
            title: 'Login',
            onTapFunction: () {
              moveToHome(context);
            },
          )
        ],
      ),
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
