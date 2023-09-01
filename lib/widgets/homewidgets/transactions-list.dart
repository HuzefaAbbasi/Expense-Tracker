// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import '../../utils/themes.dart';

class TransactionList extends StatelessWidget {
  final double screenHeight;

  const TransactionList({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = List.generate(10, (index) => TransactionModel().list[0]);

    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) =>
            TransactionItem(item: list[index]),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final MyTransaction item;
  const TransactionItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF0F6F5),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Image.asset(item.image)),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item.day,
                      style: const TextStyle(color: MyThemes.textColor),
                    )
                  ],
                )
              ],
            ),
            (item.type)
                ? Text(
                    "+ \$ ${item.amount}",
                    style: const TextStyle(
                        color: Color(0xFF25A969),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                : Text(
                    "- \$ ${item.amount}",
                    style: const TextStyle(
                        color: Color(0xFFF95B51),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
          ],
        ),
      ),
    );
  }
}
