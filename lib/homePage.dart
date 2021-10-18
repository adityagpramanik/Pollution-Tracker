// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ptracker/dashboard.dart';
import 'package:ptracker/regPage.dart';
import 'package:ptracker/utils/SharedPref.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool checkLogin = false;

  void checkStatus() async {
    var result = await SharedPref.getLog();
    if (result == null) {
      setState(() {
        checkLogin = false;
      });
    } else {
      setState(() {
        checkLogin = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: checkLogin ? Dashboard(mode: false) : RegPage(),
    );
  }
}
