import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String nameKey = "NAMEKEY";
  static String typeKey = "TYPEKEY";
  static String compKey = "COMPKEY";
  static String modelKey = "MODELKEY";
  static String mlgKey = "MLGKEY";

  static Future<bool> saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(nameKey, name);
  }

  static Future<bool> saveType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(typeKey, type);
  }

  static Future<bool> saveComp(String company) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(compKey, company);
  }

  static Future<bool> saveModel(String model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(modelKey, model);
  }

  static Future<bool> saveMlg(String mlg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(mlgKey, mlg);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(nameKey);
  }
}
