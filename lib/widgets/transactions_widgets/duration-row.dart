import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/utils/providers.dart';

import '../../utils/themes.dart';

class DurationRow extends ConsumerStatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const DurationRow({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  ConsumerState<DurationRow> createState() => _DurationRowState();
}

class _DurationRowState extends ConsumerState<DurationRow> {
  void setActiveButton(String button) {
    ref.read(durationProvider.notifier).update((state) => button);
  }

  @override
  Widget build(BuildContext context) {
    final activeButtonDuration = ref.watch(durationProvider);

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
