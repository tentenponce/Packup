// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivityStateCWProxy {
  ActivityState activity(Activity activity);

  ActivityState isEditable(bool isEditable);

  ActivityState isSelected(bool isSelected);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityState(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityState call({
    Activity? activity,
    bool? isEditable,
    bool? isSelected,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActivityState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActivityState.copyWith.fieldName(...)`
class _$ActivityStateCWProxyImpl implements _$ActivityStateCWProxy {
  final ActivityState _value;

  const _$ActivityStateCWProxyImpl(this._value);

  @override
  ActivityState activity(Activity activity) => this(activity: activity);

  @override
  ActivityState isEditable(bool isEditable) => this(isEditable: isEditable);

  @override
  ActivityState isSelected(bool isSelected) => this(isSelected: isSelected);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityState(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityState call({
    Object? activity = const $CopyWithPlaceholder(),
    Object? isEditable = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
  }) {
    return ActivityState(
      activity: activity == const $CopyWithPlaceholder() || activity == null
          ? _value.activity
          // ignore: cast_nullable_to_non_nullable
          : activity as Activity,
      isEditable:
          isEditable == const $CopyWithPlaceholder() || isEditable == null
              ? _value.isEditable
              // ignore: cast_nullable_to_non_nullable
              : isEditable as bool,
      isSelected:
          isSelected == const $CopyWithPlaceholder() || isSelected == null
              ? _value.isSelected
              // ignore: cast_nullable_to_non_nullable
              : isSelected as bool,
    );
  }
}

extension $ActivityStateCopyWith on ActivityState {
  /// Returns a callable class that can be used as follows: `instanceOfActivityState.copyWith(...)` or like so:`instanceOfActivityState.copyWith.fieldName(...)`.
  _$ActivityStateCWProxy get copyWith => _$ActivityStateCWProxyImpl(this);
}
