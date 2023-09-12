// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/firebase_services/firebase_operations.dart';
import 'package:money_tracker/utils/providers.dart';
import 'package:money_tracker/utils/routes.dart';

import '../../utils/themes.dart';
import 'income-expense-column.dart';

class BalanceCard extends ConsumerStatefulWidget {
  final double screenHeight;
  final double screenWidth;
  const BalanceCard({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  ConsumerState<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends ConsumerState<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.25,
      width: widget.screenWidth,
      margin: EdgeInsets.only(
          left: widget.screenWidth * 0.07,
          right: widget.screenWidth * 0.07,
          top: widget.screenWidth * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: widget.screenWidth * 0.05,
          vertical: widget.screenWidth * 0.07),
      decoration: const BoxDecoration(
        color: MyThemes.darkGreenColor,
        boxShadow: [
          BoxShadow(
              color: MyThemes.greenColorShadow,
              offset: Offset(5, 7),
              blurRadius: 40)
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                BalanceAmount(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IncomeExpenseColumn(
                  image: Image.asset(
                    'assets/icons/arrow-down.png',
                  ),
                  transactionType: 'Income',
                  isIncome: true,
                ),
                IncomeExpenseColumn(
                  image: Image.asset('assets/icons/arrow-up.png'),
                  transactionType: 'Expense',
                  isIncome: false,
                )
              ],
            )
          ]),
    );
  }
}

class BalanceAmount extends StatelessWidget {
  const BalanceAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: MyFirebaseOperations().getBalance(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final balance = snapshot.data;
            return Text(
              '\$ $balance',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 28),
            );
          }
        });
  }
}
