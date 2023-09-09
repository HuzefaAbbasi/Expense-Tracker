// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/transactions_widgets/transaction_body.dart';

import '../widgets/background.dart';
import '../widgets/custom-navbar.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const TransactionsBody(),
      bottomNavigationBar: CustomNavBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        isHomeActive: false,
        isTranasactionActive: true,
      ),
      extendBody: true,
    );
  }
}
