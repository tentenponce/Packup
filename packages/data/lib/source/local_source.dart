import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalSource {
  LocalSource({
    required SharedPreferences sp,
  }) : _sp = sp;

  final SharedPreferences _sp;

  static const KEY_GENERAL_NOTES = 'KEY_GENERAL_NOTES';
  static const KEY_ACTIVITIES = 'KEY_ACTIVITIES';

  Future<void> save<T>(String key, T value) {
    return _sp.setString(key, json.encode(value));
  }

  /// If you're fetching an array of object,
  /// use Iterable<dynamic>, then loop on each object
  /// to parse them individually.
  ///
  /// Example:
  /// final dynamicList = Iterable<dynamic>
  /// dynamicList.map((e) => YourObject.fromJson(e))
  T get<T>(String key) {
    final value = _sp.getString(key);

    if (value != null) {
      return json.decode(value) as T;
    } else {
      throw NullThrownError();
    }
  }
}
