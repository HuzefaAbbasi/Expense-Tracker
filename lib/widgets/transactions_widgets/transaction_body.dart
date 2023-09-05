// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/utils/providers.dart';
import 'package:money_tracker/widgets/homewidgets/page-header.dart';
import 'package:money_tracker/widgets/homewidgets/transactions-list.dart';
import 'package:money_tracker/widgets/transactions_widgets/duration-row.dart';

import '../../utils/themes.dart';

class TransactionsBody extends ConsumerWidget {
  const TransactionsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final incomeOrExpenseChoice = ref.watch(incomeOrExpenseProvider);
    final durationChoice = ref.watch(durationProvider);

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
          duration: durationChoice,
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

class IncomeExpenseChoice extends ConsumerStatefulWidget {
  const IncomeExpenseChoice({Key? key}) : super(key: key);

  @override
  ConsumerState<IncomeExpenseChoice> createState() =>
      _IncomeExpenseChoiceState();
}

class _IncomeExpenseChoiceState extends ConsumerState<IncomeExpenseChoice> {
  // To change the value of provider as user choice is changed
  void onChange(int value) {
    setState(() {
      ref.read(incomeOrExpenseProvider.notifier).update((state) => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final incomeORExpense = ref.watch(incomeOrExpenseProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DropdownButton<String>(
            value: (incomeORExpense == 0) ? 'Income' : 'Expense',
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
              (item == 'Expense') ? onChange(1) : onChange(0);
            })
      ],
    );
  }
}
