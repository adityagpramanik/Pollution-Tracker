import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String nameKey = "NAMEKEY";
  static String typeKey = "TYPEKEY";
  static String emailKey = "EMAILKEY";
  static String compKey = "COMPKEY";
  static String modelKey = "MODELKEY";
  static String mlgKey = "MLGKEY";
  static String logKey = "LOGKEY";

  // setters
  static Future<bool> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(nameKey, name);
  }

  static Future<bool> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(emailKey, email);
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

  // getters
  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(nameKey);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    return await prefs.getString(emailKey);
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

  static void showAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString(nameKey);
    String? email = prefs.getString(emailKey);
    String? type = prefs.getString(typeKey);
    String? company = prefs.getString(compKey);
    String? model = prefs.getString(modelKey);
    double? mileage = prefs.getDouble(mlgKey);
    bool? login = prefs.getBool(logKey);

    print('''
    name: $name
    email: $email
    type: $type
    company: $company
    model: $model
    mileage: $mileage
    login: $login
    ''');
  }
}
