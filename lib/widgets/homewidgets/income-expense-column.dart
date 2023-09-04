// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/firebase_services/firebase_operations.dart';

class IncomeExpenseColumn extends StatelessWidget {
  final Image image;
  final String transactionType;
  final bool isIncome;
  const IncomeExpenseColumn({
    Key? key,
    required this.image,
    required this.transactionType,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: (isIncome)
          ? MyFirebaseOperations().getIncome()
          : MyFirebaseOperations().getExpense(),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final income = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.15),
                      child: image,
                    ),
                  ),
                  Text(
                    transactionType,
                    style:
                        const TextStyle(color: Color(0xFFD0E5E4), fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '  \$ $income',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              )
            ],
          ); // Display the income in a Text widget
        }
      },
    );
  }
}
