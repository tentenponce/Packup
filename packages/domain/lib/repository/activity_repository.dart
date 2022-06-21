import 'package:domain/model/activity.dart';

abstract class ActivityRepository {
  const ActivityRepository();

  Future<void> saveActivity(Activity activity);

  Iterable<Activity> getActivities();
}
