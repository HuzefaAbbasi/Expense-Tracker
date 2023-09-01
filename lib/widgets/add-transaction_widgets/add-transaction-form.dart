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
  final TextEditingController _dateController =
      TextEditingController(text: '2023-08-06');
  final TextEditingController _amountController = TextEditingController();

  // Transaction Type selected item
  var _selectedOptionType =
      MyDropDownListItem('assets/icons/income_icon.png', 'Income');
  // Income selected item
  var _selectedOptionIncome =
      MyDropDownListItem('assets/icons/income_categories/salary.png', 'Salary');
  // Expense selected item
  var _selectedOptionExpense = MyDropDownListItem(
      'assets/icons/expense_categories/housing.png', 'Housing');

  var isIncome = true;

  // For firebase authentication
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    var selectedCategoryList = (isIncome)
        ? MyLists().incomeCategoriesList
        : MyLists().expenseCategoriesList;

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
              value: _selectedOptionType,
              items: MyLists().incomeExpenseList.map((MyDropDownListItem item) {
                return DropdownMenuItem<MyDropDownListItem>(
                  value: item,
                  child: SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Image.asset(item.iconPath),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(item.title),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: (MyDropDownListItem? item) {
                setState(() {
                  _selectedOptionType = item!;
                  isIncome = (item.title == 'Income');
                });
              },
              decoration: giveInputDecorationForDropDown(),
            ),
          ),
        )
      ],
    );

    var category = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: DropdownButtonFormField<MyDropDownListItem>(
              value:
                  (isIncome) ? _selectedOptionIncome : _selectedOptionExpense,
              items: selectedCategoryList.map((MyDropDownListItem item) {
                return DropdownMenuItem<MyDropDownListItem>(
                  value: item,
                  child: SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Image.asset(item.iconPath),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(item.title),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: (MyDropDownListItem? it) {
                setState(() {
                  (isIncome)
                      ? _selectedOptionIncome = it!
                      : _selectedOptionExpense = it!;
                });
              },
              decoration: giveInputDecorationForDropDown(),
            ),
          ),
        )
      ],
    );

    //Title Field
    var title = Column(
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

    var dateField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: giveInputDecorationDate(),
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
    //Amount Field
    var amountField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Amount",
          style: TextStyle(color: MyThemes.textColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            height: screenHeight * 0.06,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: giveInputDecorationAmount(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 9) {
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
            height: screenHeight * 0.6,
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
                title,
                const SizedBox(
                  height: 15,
                ),
                category,
                const SizedBox(
                  height: 15,
                ),
                dateField,
                const SizedBox(
                  height: 15,
                ),
                amountField

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
            height: screenHeight * 0.03,
          ),
          MainButton(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            title: 'Add',
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

// decorations for Date field
  InputDecoration giveInputDecorationDate() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      suffixIcon: GestureDetector(
        onTap: () {
          showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now());
        },
        child: const Icon(Icons.calendar_month),
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

  InputDecoration giveInputDecorationAmount() {
    return InputDecoration(
      hintText: 'Enter Amount',
      hintStyle: const TextStyle(fontSize: 15),
      prefixIcon: const Icon(Icons.attach_money),
      suffixIcon: GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clear',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyThemes.greenColor, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )),
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
