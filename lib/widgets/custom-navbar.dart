// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class CustomNaviagtionBar extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const CustomNaviagtionBar({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  State<CustomNaviagtionBar> createState() => _CustomNaviagtionBarState();
}

class _CustomNaviagtionBarState extends State<CustomNaviagtionBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.15,
      child: Stack(
        children: [Positioned(bottom: 0, child: Container())],
      ),
    );
  }
}
