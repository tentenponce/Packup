// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivityCWProxy {
  Activity name(String name);

  Activity note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Activity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Activity(...).copyWith(id: 12, name: "My name")
  /// ````
  Activity call({
    String? name,
    String? note,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActivity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActivity.copyWith.fieldName(...)`
class _$ActivityCWProxyImpl implements _$ActivityCWProxy {
  final Activity _value;

  const _$ActivityCWProxyImpl(this._value);

  @override
  Activity name(String name) => this(name: name);

  @override
  Activity note(String? note) => this(note: note);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Activity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Activity(...).copyWith(id: 12, name: "My name")
  /// ````
  Activity call({
    Object? name = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return Activity(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $ActivityCopyWith on Activity {
  /// Returns a callable class that can be used as follows: `instanceOfActivity.copyWith(...)` or like so:`instanceOfActivity.copyWith.fieldName(...)`.
  _$ActivityCWProxy get copyWith => _$ActivityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      name: json['name'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'name': instance.name,
      'note': instance.note,
    };
