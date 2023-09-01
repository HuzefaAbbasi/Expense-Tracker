import 'package:flutter/material.dart';

import '../../utils/themes.dart';

class DurationRow extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const DurationRow({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DurationButton(screenWidth: screenWidth, active: true, text: 'Day'),
        DurationButton(screenWidth: screenWidth, active: false, text: 'Week'),
        DurationButton(screenWidth: screenWidth, active: false, text: 'Month'),
        DurationButton(screenWidth: screenWidth, active: false, text: 'Year'),
      ],
    );
  }
}

class DurationButton extends StatefulWidget {
  final double screenWidth;
  final bool active;
  final String text;
  const DurationButton({
    Key? key,
    required this.screenWidth,
    required this.active,
    required this.text,
  }) : super(key: key);

  @override
  State<DurationButton> createState() => _DurationButtonState();
}

class _DurationButtonState extends State<DurationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: widget.screenWidth * 0.2,
      decoration: BoxDecoration(
        color: (widget.active) ? MyThemes.greenColor : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: (widget.active) ? Colors.white : MyThemes.textColor,
          ),
        ),
      ),
    );
  }
}
