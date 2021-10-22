// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:ptracker/pollution.dart';
import 'package:ptracker/utils/sharedPref.dart';
import 'package:ptracker/utils/emission.dart';
import 'package:ptracker/utils/event.dart';
import 'package:ptracker/utils/eventDatabase.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Dashboard extends StatefulWidget {
  bool mode;
  Dashboard({Key? key, required this.mode}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(mode);
}

class _DashboardState extends State<Dashboard> {
  bool superMode;
  _DashboardState(this.superMode);

  Emission co2em = Emission();
  GeolocatorPlatform position = GeolocatorPlatform.instance;
  StreamSubscription subs =
      GeolocatorPlatform.instance.getPositionStream().listen((event) {});
  double pointA = 0, pointB = 0, pointC = 0;
  String? name, company, model;
  String date =
      DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(DateTime.now());
  EventDatabase db = EventDatabase.instance;

  void setData() async {
    var getName = await SharedPref.getName();
    var getCompany = await SharedPref.getComp();
    var getModel = await SharedPref.getModel();

    await db.readEvent(date).then((event) {
      try {
        setState(() {
          pointA = event.valA;
          pointB = event.valB;
          pointC = event.valC;
        });
      } catch (e) {
        print('$e');
      }

      setState(() {
        name = getName!.split(" ")[0];
        company = getCompany;
        model = getModel;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    bool _mode = superMode;

    print('Widget: ' + _mode.toString());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                children: [
                  Text(
                    ("$name's ").toUpperCase(),
                    style: const TextStyle(
                      letterSpacing: 4,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    ("$company $model").toUpperCase(),
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
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Pollution(),
                    )),
                  ),
                  const SizedBox(height: 30),
                  AspectRatio(
                    aspectRatio: 1.52,
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 251, 219, 221),
                        gradient: const LinearGradient(
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
                      child: DailyChart(
                        pointA: pointA,
                        pointB: pointB,
                        pointC: pointC,
                      ),
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
                        child: Center(
                            child: Text(
                          superMode.toString() + ': ' + pointA.toString(),
                          // _mode ? "//Monthly" : "something else",
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
                        FlutterSwitch(
                          value: superMode,
                          onToggle: change,
                          activeText: "Stop",
                          inactiveText: "Start",
                          activeColor: Colors.white60,
                          inactiveColor: Colors.white60,
                          activeIcon: const Icon(
                            Icons.power_settings_new,
                            color: Colors.white,
                          ),
                          inactiveIcon:
                              const Icon(Icons.bolt, color: Colors.white),
                          borderRadius: 10,
                          height: 38,
                          width: 84,
                          showOnOff: true,
                          activeTextColor: const Color(0x99202E55),
                          inactiveTextColor: const Color(0x99202E55),
                          toggleSize: 28,
                          activeToggleColor: const Color(0XFF2827CC),
                          inactiveToggleColor: const Color(0XFF50DBB4),
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

  void change(bool val) async {
    var geoLoc = await position.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    double lati = geoLoc.latitude;
    double longi = geoLoc.longitude;

    if (val) {
      subs = position.getPositionStream().listen((event) {
        DateTime? time = event.timestamp;
        double latj = event.latitude;
        double longj = event.longitude;

        double d = position.distanceBetween(lati, longi, latj, longj);

        // print("start --> lat: $lati");
        // print("start --> long: $longi");
        // print("end --> lat: $latj");
        // print("end --> long: $longj");
        // print("distance --> $d");
        // print("distance diff: $d");
        // print("total distance: $pointA");

        if (time!.hour >= 4 && time.hour <= 12)
          pointA += d;
        else if (time.hour > 12 && time.hour <= 20)
          pointB += d;
        else if (time.hour > 20 && time.hour <= 4) pointC += d;

        lati = latj;
        longi = longj;
      });
    } else {
      var distance = pointA + pointB + pointC;
      distance = double.parse(distance.toStringAsFixed(2));
      double emission = await co2em.getEmission(distance);

      Event e = Event(
          valA: double.parse(pointA.toStringAsFixed(2)),
          valB: double.parse(pointB.toStringAsFixed(2)),
          valC: double.parse(pointC.toStringAsFixed(2)),
          distance: distance,
          checkpoint: DateTime.now(),
          emission: emission,
          time:
              DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(DateTime.now()));
      db.create(e);
      subs.pause();
    }

    setState(() {
      superMode = val;
    });
  }
}

class DailyChart extends StatefulWidget {
  double pointA, pointB, pointC;
  DailyChart(
      {Key? key,
      required this.pointA,
      required this.pointB,
      required this.pointC})
      : super(key: key);

  @override
  _DailyChartState createState() => _DailyChartState();
}

class _DailyChartState extends State<DailyChart> {
  @override
  Widget build(BuildContext context) {
    double A = widget.pointA, B = widget.pointB, C = widget.pointC;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          height: 25,
        ),
        const Text(
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
              a: A,
              b: B,
              c: C,
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
      FlSpot(indexes[0].toDouble(), valueA),
      FlSpot(indexes[1].toDouble(), valueB),
      FlSpot(indexes[2].toDouble(), valueC),
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
