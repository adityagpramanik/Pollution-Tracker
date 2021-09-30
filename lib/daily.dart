import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyChart extends StatefulWidget {
  // DailyChart({Key key}) : super(key: key);

  @override
  _DailyChartState createState() => _DailyChartState();
}

class _DailyChartState extends State<DailyChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          height: 25,
        ),
        Text(
          'Hourly Emission',
          style: TextStyle(
            color: Color(0xFFA52B14),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 6.0),
            child: DailyChartData(
              a: 2.5,
              b: 4.5,
              c: 1.5,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DailyChartData extends StatefulWidget {
  double a, b, c;
  DailyChartData({Key? key, required this.a, required this.b, required this.c})
      : super(key: key);

  @override
  _DailyChartDataState createState() => _DailyChartDataState();
}

class _DailyChartDataState extends State<DailyChartData> {
  @override
  Widget build(BuildContext context) {
    double valueA = widget.a;
    double valueB = widget.b;
    double valueC = widget.c;

    return LineChart(
      chartData(valueA, valueB, valueC),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData chartData(double a, double b, double c) {
    return LineChartData(
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titleData,
      borderData: borderData,
      lineBarsData: lineBarsData(a, b, c),
      minX: 0,
      maxX: 8,
      maxY: 5,
      minY: 0,
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.2),
          showOnTopOfTheChartBoxArea: true,
        ),
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        getDrawingVerticalLine: (value) {
          int num = value.toInt();
          num = num - 1;

          if (num % 2 == 0) {
            return FlLine(
              strokeWidth: 1,
              dashArray: [2, 4],
              color: Color(0x997744c9),
            );
          } else {
            return FlLine(strokeWidth: 0);
          }
        },
      );

  FlTitlesData get titleData => FlTitlesData(
        bottomTitles: bottomTitles,
        // bottomTitles: SideTitles(showTitles: true),
        leftTitles: leftTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xffA52B14),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) {
          const int d = 2;
          const int a = 1;

          switch (value.toInt()) {
            case a:
              return '4 AM';
            case a + d:
              return '12 PM';
            case a + 2 * d:
              return '8 PM';
            case a + 3 * d:
              return '4 AM';
          }
          return '';
        },
      );

  SideTitles get leftTitles => SideTitles(
        showTitles: true,
        margin: 10,
        interval: 1,
        reservedSize: 40,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xffA52B14),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '2%';
            case 2:
              return '4%';
            case 3:
              return '6%';
            case 4:
              return '8%';
            case 5:
              return '10%';
          }
          return '';
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xffF7AFB5), width: 4),
          left: BorderSide(
            color: Color(0xffF7AFB5),
            width: 4,
          ),
        ),
      );

  List<LineChartBarData> lineBarsData(double a, double b, double c) {
    return [
      lineBarData(a, b, c),
    ];
  }

  LineChartBarData lineBarData(double a, double b, double c) {
    return LineChartBarData(
      show: true,
      isCurved: true,
      colors: const [Color(0xffA52B14)],
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bardata, index) {
          return FlDotCirclePainter(
            radius: 10,
            color: const Color.fromRGBO(165, 43, 20, 0.7),
            strokeWidth: 0,
            // strokeColor: Colors.deepOrange,
          );
        },
      ),
      spots: [
        FlSpot(2, a),
        FlSpot(4, b),
        FlSpot(6, c),
      ],
    );
  }
}
