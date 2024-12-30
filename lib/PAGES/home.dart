// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:josiah_arising/PAGES/drawer.dart';

import '../WIDGETS/colors.dart';

class HomePageNavBar extends StatefulWidget {
  const HomePageNavBar({super.key});

  @override
  State<HomePageNavBar> createState() => _HomePageNavBarState();
}

class _HomePageNavBarState extends State<HomePageNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        backgroundColor: CustomColors.white,
        title: Text("DEVOTIONALS",
        style: TextStyle(
          color: CustomColors.blue,
          fontSize: 20,
        ),),
      ),
      drawer: CustomDrawer(),
    );
  }
}