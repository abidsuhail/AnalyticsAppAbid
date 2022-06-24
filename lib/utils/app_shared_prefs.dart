import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static const String _UID = 'uid';

  static late SharedPreferences _instance;
  static Future<void> init() async {
    ///call this at startup (in main.dart)
    _instance = await SharedPreferences.getInstance();
  }

/*  static Future<SharedPreferences> getInstance() async =>
      await SharedPreferences.getInstance();*/

  static void saveUid(String uid) {
    _instance.setString(_UID, uid);
  }

  static String? getUid() {
    return _instance.getString(_UID);
  }
}
