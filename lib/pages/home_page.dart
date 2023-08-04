// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/utils/themes.dart';
import 'package:money_tracker/widgets/background.dart';
import 'package:money_tracker/widgets/homewidgets/income-expense-column.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List list = List.generate(10, (index) => TransactionModel().list[0]);

    var notificationBox = Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: const BorderRadius.all(Radius.circular(6.67)),
      ),
      child: const Icon(
        CupertinoIcons.bell,
        color: Colors.white,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Background(screenWidth: screenWidth, screenHeight: screenHeight),
          Column(
            children: [
              SizedBox(height: screenHeight * 0.07),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Huzefa Abbasi',
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 23)),
                      ],
                    ),
                    notificationBox
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.25,
                width: screenWidth,
                margin: EdgeInsets.only(
                    left: screenWidth * 0.07,
                    right: screenWidth * 0.07,
                    top: screenWidth * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenWidth * 0.07),
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
                          Text(
                            '\$ 2,906.00',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 28),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenseColumn(
                              image: Image.asset(
                                'assets/icons/arrow-down.png',
                              ),
                              transactionType: 'Income'),
                          IncomeExpenseColumn(
                              image: Image.asset('assets/icons/arrow-up.png'),
                              transactionType: 'Expense')
                        ],
                      )
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              //Transaction History Row
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction history',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    InkWell(
                        child: Text(
                      'See all',
                      style: TextStyle(color: MyThemes.textColor),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: screenHeight * 0.39,
                child: ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) =>
                      TransactionItem(item: list[index]),
                ),
              )
              // TransactionItem(item: list[0])
            ],
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.18,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                  height: screenHeight * 0.09,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          offset: const Offset(15, -5),
                          blurRadius: 40)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/home-active.png'),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/icons/transaction.png'))
                    ],
                  ),
                )),
            Center(
                child: Container(
              height: 75,
              width: 78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyThemes.greenColor,
                boxShadow: [
                  BoxShadow(
                      color: MyThemes.greenColorShadow.withOpacity(0.7),
                      offset: const Offset(0, 7),
                      blurRadius: 48)
                ],
              ),
              child: const Icon(
                CupertinoIcons.add,
                size: 30,
                color: Colors.white,
              ),
            ))
          ],
        ),
      ),
      extendBody: true,
    );
  }
}

class CustomNavigationBar {}

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
