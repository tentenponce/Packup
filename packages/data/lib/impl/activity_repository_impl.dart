import 'package:data/source/local_source.dart';
import 'package:domain/model/activity.dart';
import 'package:domain/repository/activity_repository.dart';

class ActivityRepositoryImpl extends ActivityRepository {
  ActivityRepositoryImpl({
    required LocalSource localSource,
  }) : _localSource = localSource;

  final LocalSource _localSource;

  static const DEFAULT_ACTIVITIES = [Activity('Swimming', '')];

  /// will throw NullThrownError on first time, since there are
  /// no activities saved yet.
  ///
  /// on NullThrownError, add default activities and return it.
  @override
  Iterable<Activity> getActivities() {
    try {
      return _localSource.get(LocalSource.KEY_ACTIVITIES);
    } on NullThrownError {
      _localSource.save(LocalSource.KEY_ACTIVITIES, DEFAULT_ACTIVITIES);
      return DEFAULT_ACTIVITIES;
    }
  }

  @override
  Future<void> saveActivity(Activity activity) {
    final activities = getActivities().toList();
    activities.add(activity);
    return _localSource.save(LocalSource.KEY_ACTIVITIES, activities);
  }
}
