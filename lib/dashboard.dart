import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Row(
              children: [
                Text(
                  ("Aditya's").toUpperCase(),
                  style: TextStyle(letterSpacing: 4),
                ),
                Text(
                  ("Honda City").toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                NeumorphicContainer(
                  height: 100,
                  width: double.infinity,
                  depth: 30,
                  spread: 4,
                  borderRadius: 10,
                  primaryColor: Color.fromARGB(255, 216, 224, 245),
                  //concave neumorphism design
                  curvature: Curvature.flat,
                  child: Center(child: Text("//Pollution Pie")),
                ),
                SizedBox(height: 30),
                NeumorphicContainer(
                  spread: 4,
                  depth: 30,
                  height: 240,
                  width: double.infinity,
                  borderRadius: 10,
                  primaryColor: Color.fromARGB(255, 251, 219, 221),
                  //concave neumorphism design
                  curvature: Curvature.flat,
                  child: Center(
                      child: Text(
                    "//Daily",
                    style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                  )),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    NeumorphicContainer(
                      spread: 2,
                      depth: 60,
                      height: 240,
                      width: 170,
                      borderRadius: 10,
                      primaryColor: Color.fromARGB(255, 254, 243, 244),
                      //concave neumorphism design
                      curvature: Curvature.flat,
                      child: Center(
                          child: Text(
                        "//Weekly",
                        style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    NeumorphicContainer(
                      spread: 2,
                      depth: 60,
                      height: 240,
                      width: 170,
                      borderRadius: 10,
                      primaryColor: Color.fromARGB(255, 254, 243, 244),
                      //concave neumorphism design
                      curvature: Curvature.flat,
                      child: Center(
                          child: Text(
                        "//Monthly",
                        style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                NeumorphicContainer(
                  spread: 3,
                  depth: 40,
                  height: 100,
                  width: double.infinity,
                  borderRadius: 10,
                  primaryColor: Color.fromARGB(255, 161, 182, 239),
                  //concave neumorphism design
                  curvature: Curvature.flat,
                  child: Center(
                      child: Text(
                    "//Track mode",
                    style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
