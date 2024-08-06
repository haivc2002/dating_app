import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? _prefs;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  static Future<SharedPreferences> load() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static void setString(String key, String value) {
    _prefs?.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void setInt(String key, int value) {
    _prefs?.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    _prefs?.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs?.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static String getString(String key, {String? def}) {
    String? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs?.getString(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val ?? '';
  }

  static int getInt(String key, {int? def}) {
    int? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs?.getInt(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val ?? -1;
  }

  // static double getDouble(String key, {double def}) {
  //   double val;
  //   if (_memoryPrefs.containsKey(key)) {
  //     val = _memoryPrefs[key];
  //   }
  //   if (val == null) {
  //     val = _prefs.getDouble(key);
  //   }
  //   if (val == null) {
  //     val = def;
  //   }
  //   _memoryPrefs[key] = val;
  //   return val;
  // }

  static bool getBool(String key, {bool def = false}) {
    bool? val = _prefs?.getBool(key);
    if (val == null && _memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    } else {
      val ??= def;
    }
    _memoryPrefs[key] = val!;
    return val;
  }

  static void remove(String key) {
    _prefs?.remove(key);
    _memoryPrefs.remove(key);
  }

  static void clear() {
    _prefs?.clear();
    Global.getInt('idUser');
  }
  static String fullName = Global.getString('fullName');
}