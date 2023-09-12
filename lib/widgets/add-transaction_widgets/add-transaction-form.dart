// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/firebase_services/insert_transaction.dart';
import 'package:money_tracker/models/drop-down-list-item.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/utils/providers.dart';
import '../../utils/themes.dart';
import '../main_button.dart';

class AddTransactionForm extends ConsumerStatefulWidget {
  const AddTransactionForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends ConsumerState<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController _amountController = TextEditingController();

  // selected date by default
  var _selectedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now()); // Transaction Type selected item
  var _selectedOptionType = MyLists().incomeExpenseList[0];
  // Income selected item
  var _selectedOptionIncome = MyLists().incomeCategoriesList[0];
  // Expense selected item
  var _selectedOptionExpense = MyLists().expenseCategoriesList[0];

  var isIncome = true;

  var selectedTransactionCategoryId = 0;

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

    //Category drop down list
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

                  selectedTransactionCategoryId = it.id;
                });
                selectedTransactionCategoryId = it!.id;
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
              controller: _titleController,
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
            child: Container(
              decoration: giveDateBoxDecoration(),
              child: Row(children: [
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Text(
                  _selectedDate,
                  style: const TextStyle(fontSize: 15),
                )),
                IconButton(
                    onPressed: () async {
                      await _selectDate(context);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: MyThemes.greenColor,
                    ))
              ]),
            ),
          ),
        ),
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
            onTapFunction: () {
              FirebaseInsert().insertTransaction(MyTransaction(
                  0,
                  (isIncome) ? 0 : 1,
                  _titleController.text,
                  selectedTransactionCategoryId,
                  _selectedDate,
                  double.parse(_amountController.text)));
              ref.read(addTransactionProvider.notifier).update((state) => 1);
            },
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

  //Box Decoration for date row
  BoxDecoration giveDateBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: MyThemes.greenColor,
        width: 1.6,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  InputDecoration giveInputDecorationAmount() {
    return InputDecoration(
      hintText: 'Enter Amount',
      hintStyle: const TextStyle(fontSize: 15),
      prefixIcon: const Icon(Icons.attach_money),
      suffixIcon: GestureDetector(
          onTap: () {
            _amountController.clear();
          },
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      // Do something with the selected date
    }
  }
}
