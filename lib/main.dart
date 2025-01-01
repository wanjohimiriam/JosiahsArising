// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:josiah_arising/PAGES/home.dart';
import 'package:josiah_arising/PAGES/splashScreen.dart';

void main() {
  runApp(

    GetMaterialApp(
      title: 'Josiah Arising',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => HomePageNavBar())
      ],
  )
  );
}

