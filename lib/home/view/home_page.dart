import 'package:domain/interactor/activity/get_activities.dart';
import 'package:domain/interactor/activity/save_activity.dart';
import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/di.dart';

import 'package:packup/home/home.dart';

class HomePage extends StatelessWidget {
  final getNotes = sl<GetNotes>();
  final saveNotes = sl<SaveNotes>();
  final saveActivity = sl<SaveActivity>();
  final getActivities = sl<GetActivities>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        saveNotes: saveNotes,
        getNotes: getNotes,
        saveActivity: saveActivity,
        getActivities: getActivities,
      ),
      child: HomeView(),
    );
  }
}
