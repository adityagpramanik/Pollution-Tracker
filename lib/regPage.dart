import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  TextFormField(
                    controller: name,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text("Name"),
                      hintText: "Ajay Rathod",
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Can't be empty";
                      else if (!(value.contains(RegExp('[a-zA-Z]'))) ||
                          (value.contains(RegExp('[0-9]'))))
                        return "Please enter a valid name";
                      return null;
                    },
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
                    ),
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
                    ),
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
                    if (fkey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext) => Dashboard()));
                    }
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
