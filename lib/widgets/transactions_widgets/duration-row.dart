import 'package:flutter/material.dart';

import '../../utils/themes.dart';

String activeButtonDuration =
    'Day'; // Initialize with the default active button.

class DurationRow extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  const DurationRow({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  _DurationRowState createState() => _DurationRowState();
}

class _DurationRowState extends State<DurationRow> {
  void setActiveButton(String button) {
    setState(() {
      activeButtonDuration = button;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DurationButton(
          screenWidth: widget.screenWidth,
          active: activeButtonDuration == 'Day',
          text: 'Day',
          onPressed: () => setActiveButton('Day'),
        ),
        DurationButton(
          screenWidth: widget.screenWidth,
          active: activeButtonDuration == 'Week',
          text: 'Week',
          onPressed: () => setActiveButton('Week'),
        ),
        DurationButton(
          screenWidth: widget.screenWidth,
          active: activeButtonDuration == 'Month',
          text: 'Month',
          onPressed: () => setActiveButton('Month'),
        ),
        DurationButton(
          screenWidth: widget.screenWidth,
          active: activeButtonDuration == 'Year',
          text: 'Year',
          onPressed: () => setActiveButton('Year'),
        ),
      ],
    );
  }
}

class DurationButton extends StatelessWidget {
  final double screenWidth;
  final bool active;
  final String text;
  final VoidCallback onPressed;
  const DurationButton({
    Key? key,
    required this.screenWidth,
    required this.active,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 35,
        width: screenWidth * 0.2,
        decoration: BoxDecoration(
          color: active ? MyThemes.greenColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: active ? Colors.white : MyThemes.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
