import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/di.dart';

import 'package:packup/home/home.dart';

class HomePage extends StatelessWidget {
  final getNotes = sl<GetNotes>();
  final saveNotes = sl<SaveNotes>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        getNotes: getNotes,
        saveNotes: saveNotes,
      ),
      child: HomeView(),
    );
  }
}
