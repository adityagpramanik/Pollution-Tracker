import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Pollution extends StatefulWidget {
  Pollution({Key? key}) : super(key: key);

  @override
  _PollutionState createState() => _PollutionState();
}

class _PollutionState extends State<Pollution> {
  @override
  Widget build(BuildContext context) {
    double radius = 25;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: radius,
              child: CircleAvatar(
                radius: radius - 4,
                backgroundColor: Colors.red,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: MyPainter(),
                      child: CircleAvatar(
                        radius: radius - 3,
                        backgroundColor: Colors.amberAccent,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "2%",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff091B47)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: RichText(
              text: TextSpan(
                  style: TextStyle(color: Color(0xff091B47)),
                  children: [
                TextSpan(text: 'of '),
                TextSpan(
                    text: 'Pollution',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff091B47))),
                TextSpan(text: ' of India can be reduced'),
              ])),
        ),
      ],
    );
  }
}

class MyPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    size = Size(size.width, size.height + 20);
    Path path = Path();
    path.lineTo(size.width, size.height * 0.17);
    // path.cubicTo(size.width * 0.86, size.height * 0.72, size.width * 0.69,
    //     size.height * 1.04, size.width / 2, size.height * 1.04);

    size = Size(size.width, size.height + 20);
    path.cubicTo(size.width * 0.31, size.height * 1.04, size.width * 0.14,
        size.height * 0.72, 0, size.height * 0.17);
    path.cubicTo(size.width * 0.49, -0.26, size.width * 0.41,
        size.height * 0.56, size.width, size.height * 0.17);
    // path.cubicTo(size.width, size.height * 0.17, size.width, size.height * 0.17,
    //     size.width, size.height * 0.17);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
