import 'package:flutter/material.dart';

class FormWidgets {
  static AppBar getAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  static BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(5, 10), blurRadius: 30)
      ],
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }
}
