// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/toast.dart';
import '../../utils/routes.dart';
import '../../utils/themes.dart';
import '../main_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isVisible1 = false;
  bool isVisible2 = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // For firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // If fields are valid, this function will execute

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    moveToLogin(BuildContext context) async {
      if (_formKey.currentState!.validate()) {
        try {
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
          //Navigate to Login page
          // ignore: use_build_context_synchronously
          MyToast.makeToast('Account has been created successfully');
          Navigator.pushNamed(context, MyRoutes.loginRoute);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            MyToast.makeToast(
                'The email address is already in use by another account.');
          } else {
            MyToast.makeToast('An error occurred: ${e.message}');
          }
        } catch (e) {
          MyToast.makeToast('An unexpected error occurred.');
        }
        //
      }
    }

    //Box Decoration
    const boxDecoration = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(5, 10), blurRadius: 30)
      ],
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
    //Name Field
    var nameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: _nameController,
              decoration: giveInputDecoration(
                  hint: 'Enter name',
                  icon: const Icon(CupertinoIcons.person_crop_circle)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
    //Email Field
    var emailField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: giveInputDecoration(
                  hint: 'Enter email', icon: const Icon(CupertinoIcons.at)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
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
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: _passwordController,
              obscureText: !isVisible1,
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
              },
            ),
          ),
        )
      ],
    );
    //Confirm Password Field
    var confirmPasswordField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Confirm Password",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: !isVisible2,
              decoration: giveInputDecorationPassword2(
                hint: 'Enter password again',
                icon: const Icon(Icons.lock_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                if (value != _passwordController.text.trim()) {
                  return "Password don't match";
                }
                return null;
              },
            ),
          ),
        )
      ],
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.5,
            width: screenWidth,
            margin: EdgeInsets.all(screenWidth * 0.07),
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: boxDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Name Field
                nameField,
                const SizedBox(
                  height: 15,
                ),
                //Email Field
                emailField,
                const SizedBox(
                  height: 15,
                ),
                // Password Field
                passwordField,
                const SizedBox(
                  height: 15,
                ),
                // Confirm Password Field
                confirmPasswordField,
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          MainButton(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            title: 'Sign up',
            onTapFunction: () {
              moveToLogin(context);
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
          isVisible1 = !isVisible1;
          setState(() {});
        },
        child: (isVisible1)
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

  InputDecoration giveInputDecorationPassword2(
      {required String hint, required Icon icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 15),
      prefixIcon: icon,
      suffixIcon: GestureDetector(
        onTap: () {
          isVisible2 = !isVisible2;
          setState(() {});
        },
        child: (isVisible2)
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
