// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/homewidgets/page-header.dart';
import 'package:money_tracker/widgets/homewidgets/transactions-list.dart';
import 'package:money_tracker/widgets/transactions_widgets/duration-row.dart';

import '../../utils/themes.dart';

var incomeOrExpenseChoice = 0;

class TransactionsBody extends StatelessWidget {
  const TransactionsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //var to tell what user has choosen from drop down

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.03),
        DurationRow(screenWidth: screenWidth, screenHeight: screenHeight),
        const SizedBox(
          height: 10,
        ),
        const IncomeExpenseChoice(),
        const SizedBox(
          height: 10,
        ),

        Placeholder(
          fallbackHeight: screenHeight * 0.3,
        ),
        const SizedBox(
          height: 30,
        ),
        //Transaction History Row
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: ListTitle(),
        ),
        const SizedBox(
          height: 15,
        ),
        TransactionList(
          screenHeight: screenHeight,
          duration: activeButtonDuration,
          incomeExpense: incomeOrExpenseChoice,
        )
      ],
    );
  }
}

class ListTitle extends StatelessWidget {
  const ListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Transaction history',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        InkWell(
            child: Text(
          'See all',
          style: TextStyle(color: MyThemes.textColor),
        ))
      ],
    );
  }
}

class IncomeExpenseChoice extends StatefulWidget {
  const IncomeExpenseChoice({super.key});

  @override
  State<IncomeExpenseChoice> createState() => _IncomeExpenseChoiceState();
}

class _IncomeExpenseChoiceState extends State<IncomeExpenseChoice> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DropdownButton<String>(
            value: 'Income',
            items: ['Expense', 'Income'].map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  '   $item',
                  // textAlign: TextAlign.center,
                ),
              );
            }).toList(),
            onChanged: (String? item) {
              (item == 'Expense')
                  ? incomeOrExpenseChoice = 1
                  : incomeOrExpenseChoice;
            })
      ],
    );
  }
}
