import 'package:domain/base/use_case.dart';
import 'package:domain/model/activity.dart';
import 'package:domain/repository/activity_repository.dart';

class UpdateActivityNote extends UseCase<Activity, void> {
  UpdateActivityNote({
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  final ActivityRepository _activityRepository;

  @override
  Future<void> invoke(Activity param) async {
    return _activityRepository.insertOrUpdateActivity(param);
  }
}
