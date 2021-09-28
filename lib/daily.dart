import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ptracker/line_chart01.dart';
import 'package:ptracker/line_chart02.dart';

class DailyChart extends StatefulWidget {
  // DailyChart({Key key}) : super(key: key);

  @override
  _DailyChartState createState() => _DailyChartState();
}

class _DailyChartState extends State<DailyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff262545),
        child: ListView(
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 36.0,
                  top: 24,
                ),
                child: Text(
                  'Line Chart',
                  style: TextStyle(
                      color: Color(
                        0xff6f6f97,
                      ),
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 28,
              ),
              child: LineChartSample1(),
            ),
            const SizedBox(
              height: 22,
            ),
          ],
        ),
      ),
    );
  }
}
