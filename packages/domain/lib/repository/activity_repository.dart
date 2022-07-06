import 'package:domain/model/activity.dart';

abstract class ActivityRepository {
  const ActivityRepository();

  Future<void> saveActivity(Activity activity);

  Future<Iterable<Activity>> getActivities();

  Future<void> deleteActivity(String activityName);
}
