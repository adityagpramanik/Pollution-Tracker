import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyChart extends StatefulWidget {
  bool mode;
  DailyChart({Key? key, required this.mode}) : super(key: key);

  @override
  _DailyChartState createState() => _DailyChartState();
}

class _DailyChartState extends State<DailyChart> {
  @override
  Widget build(BuildContext context) {
    bool _mode = widget.mode;

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
              a: _mode ? 2.5 : 3.1,
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
  _DailyChartDataState createState() => _DailyChartDataState(a, b, c);
}

class _DailyChartDataState extends State<DailyChartData> {
  double valueA, valueB, valueC;
  _DailyChartDataState(this.valueA, this.valueB, this.valueC);

  final List<int> indexes = [2, 4, 6];
  late List<FlSpot> spots;
  late List<LineChartBarData> lineChartBDlist;

  @override
  Widget build(BuildContext context) {
    spots = [
      FlSpot(indexes[0].toDouble(), 2.5),
      FlSpot(indexes[1].toDouble(), 4.3),
      FlSpot(indexes[2].toDouble(), 1.8),
    ];
    lineChartBDlist = [
      LineChartBarData(
        show: true,
        showingIndicators: indexes,
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
        spots: spots,
      )
    ];

    return LineChart(
      chartData(valueA, valueB, valueC),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData chartData(double a, double b, double c) {
    return LineChartData(
      showingTooltipIndicators: [
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBDlist[0], 0, lineChartBDlist[0].spots[0]),
        ]),
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBDlist[0], 0, lineChartBDlist[0].spots[1]),
        ]),
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBDlist[0], 0, lineChartBDlist[0].spots[2]),
        ]),
      ],
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titleData,
      borderData: borderData,
      lineBarsData: lineChartBDlist,
      minX: 0,
      maxX: 8,
      maxY: 5,
      minY: 0,
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
                FlLine(
                  strokeWidth: 0,
                ),
                FlDotData(show: false));
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipMargin: 4,
          tooltipBgColor: Colors.transparent,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toString() + '%',
                const TextStyle(
                    color: Color(0xff632013), fontWeight: FontWeight.bold),
              );
            }).toList();
          },
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
              color: const Color(0x997744c9),
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
}
