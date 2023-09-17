// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/themes.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Text(text),
        ),
        const Expanded(
          child: Divider(
            color: MyThemes.textColor,
          ),
        ),
      ],
    );
  }
}
