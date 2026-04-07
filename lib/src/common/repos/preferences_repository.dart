import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  final Logger log = Logger();
  final SharedPreferences _prefs;

  PreferencesRepository(this._prefs);

  Future<void> setPreference(String key, dynamic value) async {
    log.d("PreferencesRepository::setPreference::$key - $value");
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  dynamic getPreference(String key) {
    log.d("PreferencesRepository::getPreference::$key");
    return _prefs.get(key);
  }

  Future<void> removePreference(String key) async {
    log.d("PreferencesRepository::removePreference::$key");
    await _prefs.remove(key);
  }

  Future<void> clearPreferences() async {
    log.d("PreferencesRepository::clearPreferences");
    await _prefs.clear();
  }
}
