// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/background.dart';
import 'package:money_tracker/widgets/homewidgets/home-body.dart';
import '../widgets/homewidgets/custom-navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Background(screenWidth: screenWidth, screenHeight: screenHeight),
          const HomeBody(),
        ],
      ),
      bottomNavigationBar:
          CustomNavBar(screenHeight: screenHeight, screenWidth: screenWidth),
      extendBody: true,
    );
  }
}
