import 'package:data/impl/notes_repository_impl.dart';
import 'package:data/source/local_source.dart';
import 'package:domain/interactor/save_notes.dart';
import 'package:domain/interactor/get_notes.dart';
import 'package:domain/repository/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init(BuildContext context) async {
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

  /* Repositories */
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(
      localSource: sl(),
    ),
  );

  /* Data Sources */
  final sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => sp,
  );

  sl.registerLazySingleton(
    () => LocalSource(
      sp: sl(),
    ),
  );
}
