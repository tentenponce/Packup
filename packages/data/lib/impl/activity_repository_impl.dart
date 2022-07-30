import 'package:collection/collection.dart';
import 'package:data/source/local_source.dart';
import 'package:domain/model/activity.dart';
import 'package:domain/repository/activity_repository.dart';

class ActivityRepositoryImpl extends ActivityRepository {
  ActivityRepositoryImpl({
    required LocalSource localSource,
  }) : _localSource = localSource;

  final LocalSource _localSource;

  static const DEFAULT_ACTIVITIES = [Activity(name: 'Swimming', note: '')];

  /// will throw NullThrownError on first time, since there are
  /// no activities saved yet.
  ///
  /// on NullThrownError, add default activities and return it.
  @override
  Future<Iterable<Activity>> getActivities() async {
    try {
      final dynamicList =
          _localSource.get<Iterable<dynamic>>(LocalSource.KEY_ACTIVITIES);

      return dynamicList.map((e) => Activity.fromJson(e));
    } on NullThrownError {
      await _localSource.save(LocalSource.KEY_ACTIVITIES, DEFAULT_ACTIVITIES);
      return DEFAULT_ACTIVITIES;
    }
  }

  /// This function will either add the activity if not exists,
  /// or update if exists.
  @override
  Future<void> insertOrUpdateActivity(Activity activity) async {
    final activities = await getActivities();

    final sameActivity =
        activities.firstWhereOrNull((e) => e.name == activity.name);

    List<Activity> mutableActivities;
    if (sameActivity != null) {
      /* update list if same activity */
      mutableActivities = activities.toList();

      final index =
          mutableActivities.indexWhere((e) => e.name == activity.name);

      mutableActivities[index] = activity;
    } else {
      mutableActivities = activities.toList()..add(activity);
    }

    return await _localSource.save(
      LocalSource.KEY_ACTIVITIES,
      mutableActivities,
    );
  }

  @override
  Future<void> deleteActivity(String activityName) async {
    final activities = await getActivities();
    final mutableActivities = activities.toList();

    final activityToDelete = mutableActivities
        .where((mutableActivity) =>
            mutableActivity.name.toLowerCase() == activityName.toLowerCase())
        .first;

    mutableActivities.remove(activityToDelete);

    return await _localSource.save(
      LocalSource.KEY_ACTIVITIES,
      mutableActivities,
    );
  }
}
