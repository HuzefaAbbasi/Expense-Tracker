import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/models/transaction.dart';

class MyFirebaseOperations {
  final ref = FirebaseDatabase.instance.ref();

  Future<double> getIncome() async {
    final event = await ref.child('Transactions').once();
    final snapshot = event.snapshot;
    double income = 0;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = (snapshot.value as Map);
      data.forEach((key, value) {
        if (value['transactionType'] == 0) {
          income += value['amount'];
        }
      });
    }
    return income;
  }

  Future<double> getExpense() async {
    final event = await ref.child('Transactions').once();
    final snapshot = event.snapshot;
    double income = 0;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = (snapshot.value as Map);
      data.forEach((key, value) {
        if (value['transactionType'] == 1) {
          income += value['amount'];
        }
      });
    }
    return income;
  }

  Future<double> getBalance() async {
    return await getIncome() - await getExpense();
  }

  Future<List<MyTransaction>> getTransactions({
    required String duration,
    required int transactionType,
  }) async {
    List<MyTransaction> list = [];

    // Get the current date.
    DateTime currentDate = DateTime.now();

    // For today
    DateTime startDate = currentDate;

    //Setting start date according to selected duration
    if (duration == 'Week') {
      // Calculate the start date for the previous week (7 days ago).
      startDate = currentDate.subtract(const Duration(days: 7));
    } else if (duration == 'Month') {
      // Calculate the start date for the previous month.
      startDate =
          DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    } else if (duration == 'Year') {
      // Calculate the start date for the previous year.
      startDate =
          DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
    }

    // Format the dates using intl package.
    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(currentDate);

    //query to get transactions done in specific time span.
    final event = await ref
        .child("Transactions")
        .orderByChild("date")
        .startAt(formattedStartDate)
        .endAt(formattedEndDate)
        .once();

    final snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = (snapshot.value as Map);
      data.forEach((key, value) {
        if (value['transactionType'] == transactionType) {
          //Adding transaction to list
          list.add(MyTransaction(0, value['transactionType'], value['title'],
              value['category'], value['date'], value['amount'].toDouble()));
        }
      });
    }
    return list;
  }

  // To get list of all transactions
  Future<List<MyTransaction>> getAllTransactions() async {
    List<MyTransaction> list = [];

    //query to get all transactions.
    final event = await ref.child("Transactions").once();

    final snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = (snapshot.value as Map);
      data.forEach((key, value) {
        //Adding transaction to list
        list.add(MyTransaction(0, value['transactionType'], value['title'],
            value['category'], value['date'], value['amount'].toDouble()));
      });
    }
    return list;
  }
}
