import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptracker/concaveDeco.dart';
import 'package:ptracker/dashboard.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget vertDiff = SizedBox(
    height: 30,
  );

  final fkey = GlobalKey<FormState>();

  List<String> VehicleType = ["Car", "Bike"];
  String vType = "";

  TextEditingController name = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController mileage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fkey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, -5),
                              spreadRadius: 0,
                              blurRadius: 10),
                        ]),
                    child: TextFormField(
                      controller: name,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: Text("Name"),
                          hintText: "Ajay Rathod",
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Can't be empty";
                        else if (!(value.contains(RegExp('[a-zA-Z]'))) ||
                            (value.contains(RegExp('[0-9]'))))
                          return "Please enter a valid name";
                        return null;
                      },
                    ),
                  ),
                  vertDiff,
                  Text("Vehicle Type?"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: VehicleType[0],
                            groupValue: vType,
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                vType = value!;
                              });
                            },
                          ),
                          Text("Car")
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: VehicleType[1],
                            groupValue: vType,
                            onChanged: (value) {
                              setState(() {
                                vType = value!;
                              });
                            },
                          ),
                          Text('Bike')
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Company"),
                        hintText: "Honda",
                        border: InputBorder.none),
                    controller: company,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Can't be empty";
                      else if (!(value.contains(RegExp('[a-zA-Z]'))) ||
                          (value.contains(RegExp('[0-9]'))))
                        return "Please enter a valid company";
                      return null;
                    },
                  ),
                  vertDiff,
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Model"),
                        hintText: "Amaze - S MT Petrol",
                        border: InputBorder.none),
                    controller: model,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) return "Can't be empty";
                      return null;
                    },
                  ),
                  vertDiff,
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Mileage (in km/l)"),
                      hintText: "23",
                      border: InputBorder.none,
                    ),
                    controller: mileage,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return "Can't be empty";
                      return null;
                    },
                  ),
                ],
              ),
              vertDiff,
              TextButton(
                  onPressed: () {
                    // if (fkey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext) => Dashboard()));
                    // }
                  },
                  child: Text("Proceed")),
            ],
          ),
        ),
        backgroundColor: Colors.grey[50],
      ),
    );
  }
}
