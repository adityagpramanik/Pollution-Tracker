import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptracker/homePage.dart';
import 'package:ptracker/utils/eventDatabase.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final database = EventDatabase.instance;
  
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
      home: HomePage(),
    );
  }
}
