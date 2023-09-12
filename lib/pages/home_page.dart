// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/exit_popup.dart';
import 'package:money_tracker/widgets/background.dart';
import 'package:money_tracker/widgets/homewidgets/home-body.dart';
import 'package:money_tracker/widgets/transactions_widgets/transaction-app-bar.dart';
import 'package:money_tracker/widgets/transactions_widgets/transaction_body.dart';
import '../utils/routes.dart';
import '../utils/themes.dart';
import '../widgets/custom-navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Pages on navbar
  final pages = [const HomeBody(), const TransactionsBody()];
  int index = 0; //index of first page by default.

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: (index == 1) ? TransactionAppBar().getAppBar() : null,
      body: WillPopScope(
        onWillPop: () => ExitPopup().showExitPopup(context),
        child: pages[index],
      ),
      bottomNavigationBar: getCustomNavBar(screenHeight, screenWidth),
      // bottomNavigationBar: CustomNavBar(
      //   screenHeight: screenHeight,
      //   screenWidth: screenWidth,
      //   isHomeActive: true,
      //   isTranasactionActive: false,
      // ),
      extendBody: true,
    );
  }

  Widget getCustomNavBar(double height, double width) {
    return SizedBox(
      height: height * 0.18,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Container(
                height: height * 0.09,
                width: width,
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
                        setState(() {
                          index = 0;
                        });
                        // Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      icon: (index == 0)
                          ? Image.asset('assets/icons/home-active.png')
                          : Image.asset('assets/icons/home.png'),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                          // Navigator.pushNamed(
                          //     context, MyRoutes.transactionsRoute);
                        },
                        icon: (index == 1)
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
