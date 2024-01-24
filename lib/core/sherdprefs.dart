import 'package:shared_preferences/shared_preferences.dart';

import 'string.dart';

Future<void> setBool(String key, bool value) async {
  final _prefs = await SharedPreferences.getInstance();
  await _prefs.setBool(key, value);
}

Future<void> setString(String key, String value) async {
  final _prefs = await SharedPreferences.getInstance();
  await _prefs.remove(STORAGE_USER_PROFILE_KEY);
  await _prefs.setString(key, value);
}

  Future<String?> getString(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<bool> setList(String key, List<String> value) async {
    final _prefs = await SharedPreferences.getInstance();

    return await _prefs.setStringList(key, value);
  }


  Future<List?> getList(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(key);
  }

  Future<void> remove(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }

    Future<String?> getProfile() async {
    return await getString(STORAGE_USER_PROFILE_KEY);
  }