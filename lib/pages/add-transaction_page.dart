// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/appbar.dart';
import 'package:money_tracker/widgets/background.dart';

import '../widgets/add-transaction_widgets/add-transaction-form.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: FormWidgets.getAppBar('Add Transactions'),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Background(screenWidth: screenWidth, screenHeight: screenHeight),
          SingleChildScrollView(
            child: AddTransactionBody(
                screenHeight: screenHeight, screenWidth: screenWidth),
          )
        ],
      ),
    );
  }
}

class AddTransactionBody extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const AddTransactionBody({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: screenHeight * 0.15,
      ),
      const AddTransactionForm(),
    ]);
  }
}
