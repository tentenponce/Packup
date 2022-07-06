import 'package:domain/base/use_case.dart';
import 'package:domain/repository/activity_repository.dart';

class DeleteActivity extends UseCase<String, void> {
  DeleteActivity({
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  final ActivityRepository _activityRepository;

  @override
  Future<void> invoke(String param) async {
    return _activityRepository.deleteActivity(param);
  }
}
