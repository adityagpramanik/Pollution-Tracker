// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:ptracker/daily.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                children: [
                  Text(
                    ("Aditya's ").toUpperCase(),
                    style: const TextStyle(
                      letterSpacing: 4,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    ("Honda City").toUpperCase(),
                    style: const TextStyle(
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
                  AspectRatio(
                    aspectRatio: 1.52,
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 251, 219, 221),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 250, 210, 212),
                            Color.fromARGB(255, 251, 219, 221),
                          ],
                        ),
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
                      child: DailyChart(),
                    ),
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
                          style:
                              TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
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
                          style:
                              TextStyle(color: Color.fromRGBO(164, 43, 20, 1)),
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
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Tracking Mode",
                          style: TextStyle(
                            color: Color(0xFF202E55),
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // boxShadow: [
                            //   BoxShadow(
                            //       offset: Offset(0, 2),
                            //       blurRadius: 2,
                            //       color: Colors.black.withOpacity(0.4))
                            // ]
                          ),
                          child: LiteRollingSwitch(
                            value: false,
                            textOn: 'Stop',
                            textOff: 'Start',
                            textSize: 18,
                            colorOff: Colors.indigo[300],
                            colorOn: Colors.blueGrey,
                            iconOff: Icons.bolt,
                            iconOn: Icons.power_settings_new,
                            onChanged: (bool state) {
                              // ignore: avoid_print
                              print('turned ${(state) ? 'on' : 'off'}');
                            },
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
