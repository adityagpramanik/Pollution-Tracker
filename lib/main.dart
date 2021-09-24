import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptracker/dashboard.dart';
import 'package:ptracker/dashboardReg.dart';
import 'package:ptracker/regPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PolluSync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardReg(),
    );
  }
}
