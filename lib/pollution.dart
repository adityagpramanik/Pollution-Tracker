import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Pollution extends StatefulWidget {
  double emission;
  Pollution({Key? key, required this.emission}) : super(key: key);

  @override
  _PollutionState createState() => _PollutionState();
}

class _PollutionState extends State<Pollution> {
  static const double bharatEmission = 2268;

  @override
  Widget build(BuildContext context) {
    double percentage = (widget.emission * 100) / bharatEmission;
    percentage = double.parse(percentage.toStringAsPrecision(1));
    double radius = 35;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: radius,
              child: CircleAvatar(
                radius: radius - 6,
                backgroundColor: Colors.red,
                child: Stack(
                  children: [
                    ClipPath(
                      // clipper: MyPainter(),
                      child: CircleAvatar(
                        radius: radius - 6,
                        backgroundColor:
                            const Color.fromARGB(255, 250, 210, 212),
                        // backgroundColor: Colors.amberAccent,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "$percentage%",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff091B47)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: RichText(
              text: const TextSpan(
                  style: TextStyle(color: Color(0xff091B47)),
                  children: [
                TextSpan(text: 'of Trillionth'),
                TextSpan(
                    text: '\nPollution',
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
