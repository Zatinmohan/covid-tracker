import 'package:covid/model/colorData.dart';
import 'package:flutter/material.dart';

import 'mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Covid Tracker",
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: MainPage(),
    );
  }
}
