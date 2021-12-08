import 'package:herbarium_mobile/src/core/constants/preference_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<bool> setBool(PreferenceFlag flag, {required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(flag.toString(), value);
  }

  Future<bool> setString(PreferenceFlag flag, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(flag.toString(), value);
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  Future<Object?> getPreferenceFlag(PreferenceFlag flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(flag.toString());
  }

  Future<bool> removePreferenceFlag(PreferenceFlag flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(flag.toString());
  }

  Future<bool> setInt(PreferenceFlag flag, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(flag.toString(), value);
  }

  Future<bool?> getBool(PreferenceFlag flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(flag.toString());
  }

  Future<int?> getInt(PreferenceFlag flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(flag.toString());
  }

  Future<String?> getString(PreferenceFlag flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(flag.toString());
  }
}
