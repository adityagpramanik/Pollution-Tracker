import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String nameKey = "NAMEKEY";
  static String typeKey = "TYPEKEY";
  static String compKey = "COMPKEY";
  static String modelKey = "MODELKEY";
  static String mlgKey = "MLGKEY";
  static String logKey = "LOGKEY";
  static String valAkey = "VALAKEY";
  static String valBkey = "VALBKEY";
  static String valCkey = "VALCKEY";

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

  static Future<bool> setMlg(double mlg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(mlgKey, mlg);
  }

  static Future<bool> setLog(bool logStat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(logKey, logStat);
  }

  static Future<bool> setValA(double valA) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(valAkey, valA);
  }
  static Future<bool> setValB(double valB) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(valBkey, valB);
  }
  static Future<bool> setValC(double valC) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(valCkey, valC);
  }

  // getters
  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(nameKey);
  }

  static Future<String?> getType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(typeKey);
  }

  static Future<String?> getComp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(compKey);
  }

  static Future<String?> getModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(modelKey);
  }

  static Future<double?> getMlg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(mlgKey);
  }

  static Future<bool?> getLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getBool(logKey);
  }

  static Future<double?> getValA() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getDouble(valAkey);
  }
  static Future<double?> getValB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getDouble(valBkey);
  }
  static Future<double?> getValC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getDouble(valCkey);
  }
}
