import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class Concave extends StatefulWidget {
  // Concave({Key key}) : super(key: key);
  @override
  _ConcaveState createState() => _ConcaveState();
}

class _ConcaveState extends State<Concave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NeumorphicContainer(
          height: 150,
          width: 150,
          borderRadius: 150,
          primaryColor: Color(0xFFD9E0F5),
          //concave neumorphism design
          curvature: Curvature.convex,
        ),
      ),
    );
  }
}
