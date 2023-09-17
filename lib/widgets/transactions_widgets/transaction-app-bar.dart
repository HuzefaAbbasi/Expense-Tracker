import 'package:flutter/material.dart';

class TransactionAppBar {
  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: const Text(
        'Transactions',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}
