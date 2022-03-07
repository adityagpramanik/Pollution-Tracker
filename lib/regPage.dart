// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:ptracker/dashboard.dart';
import 'package:ptracker/utils/sharedPref.dart';

class RegPage extends StatefulWidget {
  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  Widget vertDiff = SizedBox(
    height: 30,
  );

  final fkey = GlobalKey<FormState>();

  List<String> vehicleType = ["Car", "Bike"];
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
                  NeumorphicContainer(
                    borderRadius: 10,
                    depth: 60,
                    spread: 0,
                    borderColor: Colors.black26,
                    primaryColor: Colors.indigo[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: name,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            label: Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            hintText: "Ajay Rathod",
                            border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          } else if (!(value.contains(RegExp('[a-zA-Z]'))) ||
                              (value.contains(RegExp('[0-9]')))) {
                            return "Please enter a valid name";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  vertDiff,
                  const Text("Vehicle Type?"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: vehicleType[0],
                            groupValue: vType,
                            toggleable: true,
                            activeColor: Colors.indigo[900],
                            onChanged: (value) {
                              setState(() {
                                vType = value!;
                              });
                            },
                          ),
                          const Text("Car")
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: vehicleType[1],
                            groupValue: vType,
                            activeColor: Colors.indigo[900],
                            onChanged: (value) {
                              setState(() {
                                vType = value!;
                              });
                            },
                          ),
                          const Text('Bike')
                        ],
                      ),
                    ],
                  ),
                  NeumorphicContainer(
                    borderRadius: 10,
                    depth: 60,
                    spread: 0,
                    borderColor: Colors.black26,
                    primaryColor: Colors.indigo[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              "Company",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.indigo[900],
                              ),
                            ),
                            hintText: "Honda",
                            border: InputBorder.none),
                        controller: company,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          } else if (!(value.contains(RegExp('[a-zA-Z]'))) ||
                              (value.contains(RegExp('[0-9]')))) {
                            return "Please enter a valid company";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  vertDiff,
                  NeumorphicContainer(
                    borderRadius: 10,
                    depth: 60,
                    spread: 0,
                    borderColor: Colors.black26,
                    primaryColor: Colors.indigo[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              "Model",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                    ),
                  ),
                  vertDiff,
                  NeumorphicContainer(
                    borderRadius: 10,
                    depth: 60,
                    spread: 0,
                    borderColor: Colors.black26,
                    primaryColor: Colors.indigo[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            "Mileage (in km/l)",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo[900],
                            ),
                          ),
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
                    ),
                  ),
                ],
              ),
              vertDiff,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.indigo[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (fkey.currentState!.validate()) {
                    SharedPref.setName(name.text);
                    SharedPref.setType(vType);
                    SharedPref.setComp(company.text);
                    SharedPref.setModel(model.text);
                    SharedPref.setMlg(double.parse(mileage.text));
                    SharedPref.setLog(true);
                    SharedPref.setValA(0);
                    SharedPref.setValB(0);
                    SharedPref.setValC(0);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard(
                                  mode: false,
                                )));
                  }
                },
                child: Text(
                  "Proceed",
                  style: TextStyle(color: Colors.indigo[900]),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[50],
      ),
    );
  }
}
