import 'package:domain/base/use_case_no_param.dart';
import 'package:domain/model/activity.dart';
import 'package:domain/repository/activity_repository.dart';

class GetActivities extends UseCaseNoParam<Iterable<Activity>> {
  GetActivities({
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  final ActivityRepository _activityRepository;

  @override
  Future<Iterable<Activity>> invoke() async {
    return _activityRepository.getActivities();
  }
}
