import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class DashboardReg extends StatefulWidget {
  DashboardReg({Key? key}) : super(key: key);

  @override
  _DashboardRegState createState() => _DashboardRegState();
}

class _DashboardRegState extends State<DashboardReg> {
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
                  style: const TextStyle(letterSpacing: 4),
                ),
                Text(
                  ("Honda City").toUpperCase(),
                  style: const TextStyle(
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
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 224, 245),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 2),
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        offset: const Offset(1, 2),
                        color: Colors.black87.withOpacity(0.3),
                        blurRadius: 6,
                      ),
                      const BoxShadow(
                        offset: Offset(-1, -2),
                        color: Colors.white,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(child: Text("//Pollution Pie")),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 251, 219, 221),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 2),
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        offset: const Offset(1, 2),
                        color: Colors.black87.withOpacity(0.3),
                        blurRadius: 6,
                      ),
                      const BoxShadow(
                        offset: Offset(-1, -2),
                        color: Colors.white,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                      child: Text(
                    "//Daily",
                    style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                  )),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    NeumorphicContainer(
                      spread: 2,
                      depth: 40,
                      height: 240,
                      width: 170,
                      borderRadius: 10,
                      primaryColor: const Color.fromARGB(255, 254, 243, 244),
                      //concave neumorphism design
                      curvature: Curvature.flat,
                      child: const Center(
                          child: Text(
                        "//Weekly",
                        style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                      )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    NeumorphicContainer(
                      spread: 2,
                      depth: 40,
                      height: 240,
                      width: 170,
                      borderRadius: 10,
                      primaryColor: const Color.fromARGB(255, 254, 243, 244),
                      //concave neumorphism design
                      curvature: Curvature.flat,
                      child: const Center(
                          child: Text(
                        "//Monthly",
                        style: TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
                      )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                NeumorphicContainer(
                  spread: 2,
                  depth: 60,
                  height: 100,
                  width: double.infinity,
                  borderRadius: 10,
                  primaryColor: const Color.fromARGB(255, 161, 182, 239),
                  //concave neumorphism design
                  curvature: Curvature.flat,
                  child: const Center(
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
