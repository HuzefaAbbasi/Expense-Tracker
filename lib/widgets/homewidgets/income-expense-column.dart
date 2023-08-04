// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeExpenseColumn extends StatelessWidget {
  final Image image;
  final String transactionType;
  const IncomeExpenseColumn({
    Key? key,
    required this.image,
    required this.transactionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(color: Color(0xFFD0E5E4), fontSize: 18),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          '  \$ 1,202.00',
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
