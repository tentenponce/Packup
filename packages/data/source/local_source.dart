import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalSource {
  LocalSource({
    required SharedPreferences sp,
  }) : _sp = sp;

  final SharedPreferences _sp;

  Future<void> save<T>(String key, T value) {
    return _sp.setString(key, json.encode(value));
  }

  T get<T>(String key) {
    final value = _sp.getString(key);

    if (value != null) {
      return json.decode(value) as T;
    } else {
      throw NullThrownError();
    }
  }
}
