import 'package:flutter/material.dart';

class MyDropDownListItem {
  final String iconPath;
  final String title;

  MyDropDownListItem(this.iconPath, this.title);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDropDownListItem &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}
