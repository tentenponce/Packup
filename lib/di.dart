import 'package:data/impl/activity_repository_impl.dart';
import 'package:data/impl/notes_repository_impl.dart';
import 'package:data/source/local_source.dart';
import 'package:domain/interactor/activity/get_activities.dart';
import 'package:domain/interactor/activity/save_activity.dart';
import 'package:domain/interactor/activity/delete_activity.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/repository/activity_repository.dart';
import 'package:domain/repository/notes_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* Interactors */
  sl.registerLazySingleton(
    () => SaveNotes(
      notesRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetNotes(
      notesRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SaveActivity(
      activityRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetActivities(
      activityRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeleteActivity(
      activityRepository: sl(),
    ),
  );

  /* Repositories */
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(
      localSource: sl(),
    ),
  );

  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      localSource: sl(),
    ),
  );

  /* Data Sources */
  sl.registerLazySingleton(
    () => LocalSource(
      sp: sl(),
    ),
  );

  final sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => sp,
  );
}
