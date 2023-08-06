// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/models/drop-down-list-item.dart';
import 'package:money_tracker/utils/toast.dart';
import '../../utils/routes.dart';
import '../../utils/themes.dart';
import '../main_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  var _selectedOption =
      MyDropDownListItem('assets/icons/income_icon.png', 'Income');

  final List<MyDropDownListItem> _incomeExpenseList = [
    MyDropDownListItem('assets/icons/income_icon.png', 'Income'),
    MyDropDownListItem('assets/icons/expense_icon.png', 'Expense'),
  ];
  // For firebase authentication
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //Box Decoration
    const boxDecoration = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(5, 10), blurRadius: 30)
      ],
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
    //Transaction Type Drop Down
    var transactionype = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Transaction Type",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: DropdownButtonFormField<MyDropDownListItem>(
              value: _selectedOption,
              items: _incomeExpenseList.map((MyDropDownListItem item) {
                return DropdownMenuItem<MyDropDownListItem>(
                  value: item,
                  child: Row(
                    children: [
                      Image.asset(item.iconPath),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(item.title),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (MyDropDownListItem? it) {
                setState(() {
                  _selectedOption = it!;
                });
              },
              decoration: giveInputDecorationForDropDown(),
            ),
          ),
        )
      ],
    );

    //Name Field
    var nameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Title",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: _nameController,
              decoration: giveInputDecoration(
                  hint: 'Enter title',
                  icon: const Icon(CupertinoIcons.wand_rays_inverse)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
    //Email Field
    // var emailField = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const Text(
    //       "Email",
    //       style: TextStyle(color: MyThemes.textColor),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 12.0),
    //       child: SizedBox(
    //         height: screenHeight * 0.06,
    //         child: TextFormField(
    //           controller: _emailController,
    //           keyboardType: TextInputType.emailAddress,
    //           decoration: giveInputDecoration(
    //               hint: 'Enter email', icon: const Icon(CupertinoIcons.at)),
    //           validator: (value) {
    //             if (value == null || value.isEmpty) {
    //               return 'Please enter email';
    //             }
    //             return null;
    //           },
    //         ),
    //       ),
    //     )
    //   ],
    // );
    // //Password Field
    // var passwordField = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const Text(
    //       "Password",
    //       style: TextStyle(color: MyThemes.textColor),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 12.0),
    //       child: SizedBox(
    //         height: screenHeight * 0.06,
    //         child: TextFormField(
    //           controller: _passwordController,
    //           obscureText: !isVisible1,
    //           decoration: giveInputDecorationPassword1(
    //             hint: 'Enter password',
    //             icon: const Icon(Icons.lock_outline),
    //           ),
    //           validator: (value) {
    //             if (value == null || value.isEmpty) {
    //               return 'Please enter password';
    //             }
    //             if (value.length < 9) {
    //               return 'Password should be atleast 8 characters long';
    //             }
    //             return null;
    //           },
    //         ),
    //       ),
    //     )
    //   ],
    // );
    // //Confirm Password Field
    // var confirmPasswordField = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const Text(
    //       "Confirm Password",
    //       style: TextStyle(color: MyThemes.textColor),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 12.0),
    //       child: SizedBox(
    //         height: screenHeight * 0.06,
    //         child: TextFormField(
    //           controller: _confirmPasswordController,
    //           obscureText: !isVisible2,
    //           decoration: giveInputDecorationPassword2(
    //             hint: 'Enter password again',
    //             icon: const Icon(Icons.lock_outline),
    //           ),
    //           validator: (value) {
    //             if (value == null || value.isEmpty) {
    //               return 'Please enter password';
    //             }
    //             if (value != _passwordController.text.trim()) {
    //               return "Password don't match";
    //             }
    //             return null;
    //           },
    //         ),
    //       ),
    //     )
    //   ],
    // );

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
                transactionype,
                const SizedBox(
                  height: 15,
                ),
                //Name Field
                nameField,
                const SizedBox(
                  height: 15,
                ),
                // //Email Field
                // emailField,
                // const SizedBox(
                //   height: 15,
                // ),
                // // Password Field
                // passwordField,
                // const SizedBox(
                //   height: 15,
                // ),
                // // Confirm Password Field
                // confirmPasswordField,
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
            onTapFunction: () {},
          )
        ],
      ),
    );
  }

  // Decoration for name and email field.
  InputDecoration giveInputDecorationForDropDown() {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyThemes.greenColor, width: 1.6),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyThemes.greenColor,
            width: 1.6,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))),
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

// // decorations for password field, separate because of visibility
//   InputDecoration giveInputDecorationPassword1(
//       {required String hint, required Icon icon}) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 15),
//       prefixIcon: icon,
//       suffixIcon: GestureDetector(
//         onTap: () {
//           isVisible1 = !isVisible1;
//           setState(() {});
//         },
//         child: (isVisible1)
//             ? const Icon(Icons.visibility_outlined)
//             : const Icon(Icons.visibility_off_outlined),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderSide: BorderSide(
//           color: MyThemes.greenColor,
//         ),
//       ),
//       enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             color: MyThemes.greenColor,
//             width: 1.6,
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(8))),
//     );
//   }

//   InputDecoration giveInputDecorationPassword2(
//       {required String hint, required Icon icon}) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 15),
//       prefixIcon: icon,
//       suffixIcon: GestureDetector(
//         onTap: () {
//           isVisible2 = !isVisible2;
//           setState(() {});
//         },
//         child: (isVisible2)
//             ? const Icon(Icons.visibility_outlined)
//             : const Icon(Icons.visibility_off_outlined),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderSide: BorderSide(
//           color: MyThemes.greenColor,
//         ),
//       ),
//       enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             color: MyThemes.greenColor,
//             width: 1.6,
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(8))),
//     );
//   }
// }
}
