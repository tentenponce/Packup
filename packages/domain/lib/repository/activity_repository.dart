import 'package:domain/model/activity.dart';

abstract class ActivityRepository {
  const ActivityRepository();

  Future<void> insertOrUpdateActivity(Activity activity);

  Future<Iterable<Activity>> getActivities();

  Future<void> deleteActivity(String activityName);
}
