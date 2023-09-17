// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/drop-down-list-item.dart';
import 'package:money_tracker/utils/providers.dart';
import 'package:money_tracker/utils/toast.dart';

import '../../firebase_services/firebase_operations.dart';
import '../../models/transaction.dart';
import '../../utils/themes.dart';

class TransactionList extends ConsumerWidget {
  final double screenHeight;
  final ref = FirebaseDatabase.instance.ref('Transactions');
  String duration;
  int incomeExpense;

  TransactionList({
    Key? key,
    required this.screenHeight,
    required this.duration,
    required this.incomeExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addTransactionProvider);
    return FutureBuilder<List<MyTransaction>>(
        future: (incomeExpense == 2)
            ? MyFirebaseOperations().getAllTransactions()
            : MyFirebaseOperations().getTransactions(
                duration: duration, transactionType: incomeExpense),
        builder: (BuildContext context,
            AsyncSnapshot<List<MyTransaction>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            return const Text('No Data Available');
          } else {
            final list = snapshot.data;
            return Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: screenHeight * 0.09),
              itemCount: list!.length,
              itemBuilder: (context, index) =>
                  TransactionItem(item: list[index]),
            ));
          }
        });
  }
}

class TransactionItem extends ConsumerStatefulWidget {
  final MyTransaction item;
  const TransactionItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  ConsumerState<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends ConsumerState<TransactionItem> {
  var isLongPressed = false;
  @override
  Widget build(BuildContext context) {
    var imagePath = (widget.item.type == 0)
        ? MyLists().incomeCategoriesList[widget.item.category].iconPath
        : MyLists().expenseCategoriesList[widget.item.category].iconPath;

    return InkWell(
      onLongPress: () {
        setState(() {
          isLongPressed = true;
        });
      },
      onTap: () {
        setState(() {
          isLongPressed = false;
        });
      },
      child: SizedBox(
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
                      child: (isLongPressed)
                          ? IconButton(
                              icon: const Icon(CupertinoIcons.delete),
                              onPressed: () {
                                MyFirebaseOperations().deleteTransaction(
                                    widget.item.id.toString());
                                MyToast.makeToast('Transaction Deleted');
                                // just so widget listens to change, doesnt matter what is the value
                                ref
                                    .read(addTransactionProvider.notifier)
                                    .update((state) => 6);
                              }).animate().flipH()
                          : Image.asset(imagePath)),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item.date,
                        style: const TextStyle(color: MyThemes.textColor),
                      )
                    ],
                  )
                ],
              ),
              (widget.item.type == 0)
                  ? Text(
                      "+ \$ ${widget.item.amount}",
                      style: const TextStyle(
                          color: Color(0xFF25A969),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  : Text(
                      "- \$ ${widget.item.amount}",
                      style: const TextStyle(
                          color: Color(0xFFF95B51),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
            ],
          ),
        ),
      ).animate().scaleY(delay: const Duration(milliseconds: 500)),
    );
  }
}
