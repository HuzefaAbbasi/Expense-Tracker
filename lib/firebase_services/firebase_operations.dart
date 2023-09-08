import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

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

  Future<List<FlSpot>> getFlSpots({
    required String duration,
    required int transactionType,
  }) async {
    List<MyTransaction> transactions = await getTransactions(
      duration: duration,
      transactionType: transactionType,
    );

    // Initialize a list to store FlSpots
    List<FlSpot> flSpots = [];

    // For day
    if (duration == 'Day') {
      for (int i = 0; i < transactions.length; i++) {
        MyTransaction transaction = transactions[i];
        // Create an FlSpot object and add it to the list
        var amount = transaction.amount;
        if (transaction.amount > 100000) {
          amount = 100000;
        }
        flSpots.add(FlSpot(i.toDouble() + 1, amount / 10000));
      }
    } // For week returns sum of transactions for each day
    else if (duration == 'Week') {
      Map<String, double> weeklySums = {
        'Monday': 0.0,
        'Tuesday': 0.0,
        'Wednesday': 0.0,
        'Thursday': 0.0,
        'Friday': 0.0,
        'Saturday': 0.0,
        'Sunday': 0.0,
      };

      for (int i = 0; i < transactions.length; i++) {
        MyTransaction transaction = transactions[i];
        // Parse the transaction date to get the day of the week
        DateTime transactionDate = DateTime.parse(transaction.date);
        String? dayOfWeek = DateFormat('EEEE').format(transactionDate);
        // Update the sum for the corresponding day of the week
        double? prevVal = weeklySums[dayOfWeek] ?? 0;
        weeklySums[dayOfWeek] = prevVal + transaction.amount;
      }

      // Iterate through the values in the map and create FlSpot objects
      for (int i = 0; i < weeklySums.length; i++) {
        double sum = weeklySums.values.elementAt(i);
        if (sum > 100000) {
          sum = 100000;
        }
        flSpots.add(FlSpot(i.toDouble() + 1, sum / 10000));
      }
    } else if (duration == 'Year') {
      Map<int, double> monthlySums = {
        1: 0.0,
        2: 0.0,
        3: 0.0,
        4: 0.0,
        5: 0.0,
        6: 0.0,
        7: 0.0,
        8: 0.0,
        9: 0.0,
        10: 0.0,
        11: 0.0,
        12: 0.0,
      };

      // Process the transactions and update monthly sums
      for (int i = 0; i < transactions.length; i++) {
        MyTransaction transaction = transactions[i];

        // Parse the transaction date to extract the month
        DateTime transactionDate = DateTime.parse(transaction.date);
        int month = transactionDate.month;

        // Update the sum for the corresponding month
        double? prevVal = monthlySums[month] ?? 0;
        monthlySums[month] = prevVal + transaction.amount;
      }

      // Iterate through the values in the map and create FlSpot objects
      for (int i = 0; i < monthlySums.length; i++) {
        double sum = monthlySums.values.elementAt(i);
        if (sum > 100000) {
          sum = 100000;
        }
        flSpots.add(FlSpot(i.toDouble() + 1, sum / 10000));
      }
    } else {
      Map<int, double> daysOfMonth = {};
      for (int i = 0; i < transactions.length; i++) {
        MyTransaction transaction = transactions[i];
        // Parse the transaction date to get the day of the week
        DateTime transactionDate = DateTime.parse(transaction.date);
        int day = transactionDate.day;
        // Update the sum for the corresponding day of the week
        // Update the sum for the corresponding month
        double? prevVal = 0;
        if (daysOfMonth.containsKey(day)) {
          prevVal = daysOfMonth[day] ?? 0;
          daysOfMonth[day] = prevVal + transaction.amount;
        } else {
          daysOfMonth[day] = transaction.amount;
        }
      }
      // Iterate through the values in the map and create FlSpot objects
      for (int i = 0; i < daysOfMonth.length; i++) {
        double sum = daysOfMonth.values.elementAt(i);
        if (sum > 100000) {
          sum = 100000;
        }
        flSpots.add(FlSpot(i.toDouble() + 1, sum / 10000));
      }
    }
    return flSpots;
  }
}
