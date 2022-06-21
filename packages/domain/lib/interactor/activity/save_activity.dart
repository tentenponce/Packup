import 'package:domain/base/use_case.dart';
import 'package:domain/model/activity.dart';
import 'package:domain/repository/activity_repository.dart';

class SaveActivity extends UseCase<Activity, void> {
  SaveActivity({
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  final ActivityRepository _activityRepository;

  @override
  Future<void> invoke(Activity param) {
    return _activityRepository.saveActivity(param);
  }
}
