// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';

import '../utils/themes.dart';

class CustomNavBar extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final bool isHomeActive;
  final bool isTranasactionActive;
  const CustomNavBar({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.isHomeActive,
    required this.isTranasactionActive,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenHeight * 0.18,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Container(
                height: widget.screenHeight * 0.09,
                width: widget.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        offset: const Offset(15, -5),
                        blurRadius: 40)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      icon: (widget.isHomeActive)
                          ? Image.asset('assets/icons/home-active.png')
                          : Image.asset('assets/icons/home.png'),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.transactionsRoute);
                        },
                        icon: (widget.isTranasactionActive)
                            ? Image.asset('assets/icons/transaction-active.png')
                            : Image.asset('assets/icons/transaction.png'))
                  ],
                ),
              )),
          Center(
              child: InkWell(
            onTap: () =>
                Navigator.pushNamed(context, MyRoutes.addTransactionsRoute),
            child: Container(
              height: 75,
              width: 78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyThemes.greenColor,
                boxShadow: [
                  BoxShadow(
                      color: MyThemes.greenColorShadow.withOpacity(0.7),
                      offset: const Offset(0, 7),
                      blurRadius: 30)
                ],
              ),
              child: const Icon(
                CupertinoIcons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
