import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String nameKey = "NAMEKEY";
  static String typeKey = "TYPEKEY";
  static String compKey = "COMPKEY";
  static String modelKey = "MODELKEY";
  static String mlgKey = "MLGKEY";
  static String logKey = "LOGKEY";

  // setters
  static Future<bool> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(nameKey, name);
  }

  static Future<bool> setType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(typeKey, type);
  }

  static Future<bool> setComp(String company) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(compKey, company);
  }

  static Future<bool> setModel(String model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(modelKey, model);
  }

  static Future<bool> setMlg(String mlg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(mlgKey, mlg);
  }

  static Future<bool> setLog(bool mlg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(mlgKey, mlg);
  }

  // getters
  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(nameKey);
  }

  static Future<String?> getType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(typeKey);
  }

  static Future<String?> getComp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(compKey);
  }

  static Future<String?> getModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(modelKey);
  }

  static Future<String?> getMlg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(mlgKey);
  }

  static Future<bool?> getLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(mlgKey);
  }
}
