import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:ptracker/pollution.dart';
import 'package:ptracker/utils/databasehelper.dart';
import 'package:ptracker/utils/sharedPref.dart';
import 'package:ptracker/utils/emission.dart';
import 'package:ptracker/utils/event.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:uuid/uuid.dart';

const double CPL = 2428;

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
  String? name, company, model;
  double distance = 0;

  late double? mlg;
  late double emission = 0;
  late DateTime tstart, tend;

  void setData() async {
    var getName = await SharedPref.getName();
    var getCompany = await SharedPref.getComp();
    var getModel = await SharedPref.getModel();
    mlg = await SharedPref.getMlg();

    setState(() {
      name = getName!.split(" ")[0];
      company = getCompany;
      model = getModel;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    print('Widget: ' + superMode.toString());

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
                      child: Pollution(
                          emission:
                              double.parse(emission.toStringAsPrecision(2))),
                    )),
                  ),
                  // const SizedBox(height: 30), //beffore
                  const SizedBox(height: 120),
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
                      child: DailyChart(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(
                    height: 50,
                  ),

                  const Text("Test Text: "),

                  GestureDetector(
                      onTap: fetchUserData,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 40,
                        color: Colors.blue,
                        child: const Text("add event"),
                      )),

                  GestureDetector(
                      onTap: () {
                        SharedPref.showAll();
                        DatabaseHelper.instance.getEvents();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 40,
                        color: Colors.blue,
                        child: const Text("get event"),
                      )),

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

  void fetchUserData() async {
    var res = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/10"));

    try {
      dynamic response = json.decode(res.body);
      print(response);
    } catch (e) {
      print(e.toString() + " \n" + res.statusCode.toString());
    }

    Uuid uuid = Uuid();
    String eid = uuid.v1().toString();
    var format = DateFormat("yy-MM-d HH:mm");

    DatabaseHelper.instance.addEvent(Event(
        eid: eid,
        start: format.format(DateTime.now().subtract(const Duration(hours: 3))),
        end: format.format(DateTime.now()),
        slota: 8,
        slotb: 9,
        slotc: 15));
  }

  void change(bool val) async {
    if (superMode) {
      tend = DateTime.now();
    } else if (!superMode) {
      tstart = DateTime.now();
    }

    setState(() {
      superMode = !superMode;
    });

    var permission = await position.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await position.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Permission denied");
      }
    }
    Position geoLoc = await position.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    double lati = geoLoc.latitude;
    double longi = geoLoc.longitude;
    double fuelUsed;

    if (val) {
      subs = position.getPositionStream().listen((event) {
        double latj = event.latitude;
        double longj = event.longitude;

        double d = position.distanceBetween(lati, longi, latj, longj);

        if (d.floor() != 0 && d.floor() != 1) {
          distance += d;
        }

        debugPrint(d.toString() + " : " + distance.toString());

        lati = latj;
        longi = longj;
      });
    } else {
      Uuid uuid = const Uuid();
      DateFormat format = DateFormat("yy-MM-d HH:mm");
      DatabaseHelper db = DatabaseHelper.instance;

      debugPrint("distance: $distance");
      debugPrint("distance (int): ${distance.floor()}");
      debugPrint("start time: " + tstart.toString());
      debugPrint("end time: " + tend.toString());

      List<double> slots = getDistanceSlots(tstart, tend, distance);

      setState(() {
        distance = 0;
      });

      debugPrint("distance from each segment: $slots");

      Event event = Event(
          eid: uuid.v1().toString(),
          start: format.format(tstart),
          end: format.format(tend),
          slota: slots[0],
          slotb: slots[1],
          slotc: slots[2]);

      db.addEvent(event);

      subs.pause();
    }
  }

  List<double> getDistanceSlots(DateTime start, DateTime end, double distance) {
    // TIME BAND
    // 4*60 = 240 ------- 12*60 = 720 ------- 20*60 = 1200 ----- (20+4)*60 = 1680

    List<double> slots = [0, 0, 0];
    Map<DateTime, int> timeslot = {};
    double velocity;

    Duration timeDiff = end.difference(start);

    print("time difference: $timeDiff");

    int startsum = start.hour * 60 + start.minute;
    int endsum = end.hour * 60 + end.minute;

    if (start.hour >= 0 && start.hour < 4) {
      startsum = (startsum + 24) * 60 + start.minute;
    }
    if (end.hour >= 0 && end.hour < 4) {
      endsum = (endsum + 24) * 60 + end.minute;
    }

    // for starting timestamp
    if (startsum >= 240 && startsum <= 720) {
      timeslot[start] = 1;
    } else if (startsum > 720 && startsum <= 1200) {
      timeslot[start] = 2;
    } else {
      timeslot[start] = 3;
    }

    // for ending timestamp
    if (endsum >= 240 && endsum <= 720) {
      timeslot[end] = 1;
    } else if (endsum > 720 && endsum <= 1200) {
      timeslot[end] = 2;
    } else {
      timeslot[end] = 3;
    }

    if (distance.floor() != 0 && endsum > startsum) {
      int time = (timeDiff.inHours * 60) + timeDiff.inMinutes;
      velocity = distance / time;

      if (velocity.floor() != 0) {
        if (timeslot[start] == 1 && timeslot[end] == 1) {
          // slot - A
          slots[0] = velocity * (endsum - startsum);

          if (timeDiff.inDays != 0) {
            slots[0] = timeDiff.inDays * (velocity * (endsum - startsum));
          }
        } else if (timeslot[start] == 2 && timeslot[end] == 2) {
          // slot - B
          slots[1] = velocity * (endsum - startsum);

          if (timeDiff.inDays != 0) {
            slots[1] = timeDiff.inDays * (velocity * (endsum - startsum));
          }
        } else if (timeslot[start] == 3 && timeslot[end] == 3) {
          // slot - C
          slots[2] = velocity * (endsum - startsum);

          if (timeDiff.inDays != 0) {
            slots[2] = timeDiff.inDays * (velocity * (endsum - startsum));
          }
        } else if (timeslot[start] == 1 && timeslot[end] == 2) {
          // A-B
          slots[0] = velocity * (720 - startsum);

          if (timeDiff.inDays != 0) {
            slots[0] = timeDiff.inDays * (velocity * (720 - startsum));
          }

          slots[1] = velocity * (endsum - 720);

          if (timeDiff.inDays != 0) {
            slots[1] = timeDiff.inDays * (velocity * (endsum - 720));
          }
        } else if (timeslot[start] == 1 && timeslot[end] == 3) {
          // A-C
          slots[0] = velocity * (720 - startsum);
          if (timeDiff.inDays != 0) {
            slots[0] = timeDiff.inDays * (velocity * (720 - startsum));
          }

          slots[1] = velocity * 480;
          if (timeDiff.inDays != 0) {
            slots[1] = timeDiff.inDays * velocity * 480;
          }

          slots[2] = velocity * (endsum - 1200);
          if (timeDiff.inDays != 0) {
            slots[2] = timeDiff.inDays * (velocity * (endsum - 1200));
          }
        } else if (timeslot[start] == 2 && timeslot[end] == 3) {
          // B-C
          slots[1] = velocity * (1200 - startsum);
          if (timeDiff.inDays != 0) {
            slots[1] = timeDiff.inDays * velocity * (1200 - startsum);
          }

          slots[2] = velocity * (endsum - 1200);
          if (timeDiff.inDays != 0) {
            slots[2] = timeDiff.inDays * (velocity * (endsum - 1200));
          }
        }
      }
    }

    return slots;
  }
}

class DailyChart extends StatefulWidget {
  DailyChart({Key? key}) : super(key: key);

  @override
  _DailyChartState createState() => _DailyChartState();
}

class _DailyChartState extends State<DailyChart> {
  late double A, B, C, mlg;

  void setData() async {
    double? valMlg = await SharedPref.getMlg();

    setState(() {
      A = 5;
      B = 8;
      C = 4;
      mlg = valMlg!;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          height: 25,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Hourly Emission',
            style: TextStyle(
              color: Color(0xFFA52B14),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 6.0),
            child: DailyChartData(),
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
  DailyChartData({Key? key}) : super(key: key);

  @override
  _DailyChartDataState createState() => _DailyChartDataState();
}

class _DailyChartDataState extends State<DailyChartData> {
  final List<int> indexes = [2, 4, 6];
  late List<FlSpot> spots;
  late List<LineChartBarData> lineChartBDlist;
  double A = 4, B = 5, C = 8;
  double mlg = 18;

  // void setData() async {
  //   double? valMlg = await SharedPref.getMlg();

  //   setState(() {
  //     mlg = valMlg!;
  //     mlg = 18;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setData();
  // }

  @override
  Widget build(BuildContext context) {
    double valueA = A, valueB = B, valueC = C;
    valueA = valueA * CPL / mlg * 1000;
    valueB = valueB * CPL / mlg * 1000;
    valueC = valueC * CPL / mlg * 1000;

    print("A: $valueA");
    print("B: $valueB");
    print("C: $valueC");

    setState(() {
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
    });

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
