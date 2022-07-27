import 'package:domain/base/use_case.dart';
import 'package:domain/errors/duplicate_error.dart';
import 'package:domain/model/activity.dart';
import 'package:domain/repository/activity_repository.dart';

class SaveActivity extends UseCase<Activity, void> {
  SaveActivity({
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  final ActivityRepository _activityRepository;

  @override
  Future<void> invoke(Activity param) async {
    if (param.name.isEmpty) {
      throw NullThrownError();
    }

    final activities = await _activityRepository.getActivities();

    final isExists = activities
        .where((activity) =>
            activity.name.toLowerCase().contains(param.name.toLowerCase()))
        .isNotEmpty;

    if (isExists) {
      throw DuplicateError();
    }

    return _activityRepository.insertOrUpdateActivity(param);
  }
}
