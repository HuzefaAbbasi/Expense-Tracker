// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/homewidgets/page-header.dart';
import 'package:money_tracker/widgets/homewidgets/transactions-list.dart';

import '../../utils/themes.dart';
import 'balance-card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.07),
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: const PageHeader(),
        ),
        BalanceCard(screenHeight: screenHeight, screenWidth: screenWidth),
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
          duration: 'Not Specified',
          incomeExpense:
              2, // 2 is used for all transactions, both income and expense
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
