import 'package:flutter/material.dart';
import 'package:ptracker/utils/sharedPref.dart';

class Emission {
  // Diesel - 2640g of CO2/l
  // Petrol - 2392g of CO2/l
  // CNG    - 2252g of CO2/l
  // Avg    = 2428g of CO2/l
  static const double CPL = 2428;

  Future<double> getEmission(double distance) async {
    String mlg = await SharedPref.getMlg().toString();
    
    mlg = double.parse(mlg).toStringAsFixed(2);
    double M = double.parse(mlg);

    double fuelUsed = distance / M;
    double emission = CPL * fuelUsed;

    return double.parse(emission.toStringAsFixed(2));
  }
}
