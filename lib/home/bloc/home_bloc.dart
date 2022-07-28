import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/errors/duplicate_error.dart';
import 'package:domain/interactor/activity/delete_activity.dart';
import 'package:domain/interactor/activity/get_activities.dart';
import 'package:domain/interactor/activity/save_activity.dart';
import 'package:domain/interactor/activity/update_activity_note.dart';
import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:domain/model/activity.dart';
import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.g.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetNotes getNotes,
    required SaveNotes saveNotes,
    required GetActivities getActivities,
    required SaveActivity saveActivity,
    required DeleteActivity deleteActivity,
    required UpdateActivityNote updateActivityNote,
  })  : _getNotes = getNotes,
        _saveNotes = saveNotes,
        _getActivities = getActivities,
        _saveActivity = saveActivity,
        _deleteActivity = deleteActivity,
        _updateActivityNote = updateActivityNote,
        super(HomeState()) {
    on<HomeInit>(_onHomeInit);
    on<HomeNextPage>(_onHomeNextPage);
    on<HomePreviousPage>(_onHomePreviousPage);
    on<HomeDayCountChanged>(_onHomeDayCountChanged);
    on<HomeNightCountChanged>(_onHomeNightCountChanged);
    on<HomeResetValues>(_onHomeResetValues);
    on<HomeEditNotes>(_onHomeEditNotes);
    on<HomeSaveNotes>(_onHomeSaveNotes);
    on<HomeNotesChanged>(_onHomeNotesChanged);
    on<HomeAddActivity>(_onHomeAddActivity);
    on<HomeEditActivityNote>(_onHomeEditActivityNote);
    on<HomeDeleteActivity>(_onHomeDeleteActivity);
    on<HomeActivityNoteChanged>(_onHomeActivityNoteChanged);
    on<HomeSaveActivityNote>(_onHomeSaveActivityNote);
    on<HomeActivityToggle>(_onHomeActivityToggle);
  }

  final GetNotes _getNotes;
  final SaveNotes _saveNotes;
  final GetActivities _getActivities;
  final SaveActivity _saveActivity;
  final DeleteActivity _deleteActivity;
  final UpdateActivityNote _updateActivityNote;

  /* one time events */
  Stream<String> get showDuplicateActivity => _showDuplicateActivity.stream;
  final _showDuplicateActivity = StreamController<String>.broadcast();

  Stream<void> get showEmptyActivity => _showEmptyActivity.stream;
  final _showEmptyActivity = StreamController<void>.broadcast();

  @override
  Future<void> close() {
    _showDuplicateActivity.close();
    _showEmptyActivity.close();
    return super.close();
  }

  Future<void> _onHomeInit(
    HomeInit event,
    Emitter<HomeState> emit,
  ) async {
    final activities = await _getActivities.invoke();

    // by default, activities are not-editable and not selected
    emit(
      state.copyWith(
        activities: activities.map(
          (e) => ActivityState(
            activity: e,
            isEditable: false,
            isSelected: false,
          ),
        ),
      ),
    );
  }

  Future<void> _onHomeNextPage(
    HomeNextPage event,
    Emitter<HomeState> emit,
  ) async {
    var currentPageIndex = pageOrder.indexOf(state.page);

    if (currentPageIndex < pageOrder.length - 1) {
      if (state.page == HomePages.dayCount && !state.validDayCount) {
        return;
      }

      if (state.page == HomePages.nightCount && !state.validNightCount) {
        return;
      }

      final page = pageOrder[currentPageIndex + 1];

      if (page == HomePages.summary) {
        final notes = await _getNotes.invoke();
        emit(state.copyWith(page: page, notes: notes));
      } else {
        emit(state.copyWith(page: page));
      }
    }
  }

  void _onHomePreviousPage(
    HomePreviousPage event,
    Emitter<HomeState> emit,
  ) {
    var currentPageIndex = pageOrder.indexOf(state.page);

    if (currentPageIndex > 0) {
      emit(state.copyWith(page: pageOrder[currentPageIndex - 1]));
    }
  }

  void _onHomeDayCountChanged(
    HomeDayCountChanged event,
    Emitter<HomeState> emit,
  ) {
    var isValid = RegExp(r'^[0-9]+$').hasMatch(event.dayCount);

    var dayCount = event.dayCount;
    if (!isValid) {
      dayCount = HomeState.DEFAULT_DAY_COUNT;
    }

    emit(state.copyWith(
      dayCount: event.dayCount,
      validDayCount: isValid,
      dayClothes:
          int.parse(dayCount) + _countSelectedActivities(state.activities) - 1,
      underwear: ((int.parse(dayCount) - 1) * 2) + 1,
    ));
  }

  void _onHomeNightCountChanged(
    HomeNightCountChanged event,
    Emitter<HomeState> emit,
  ) {
    var isValid = RegExp(r'^[0-9]+$').hasMatch(event.nightCount);

    var nightCount = event.nightCount;
    if (!isValid) {
      nightCount = HomeState.DEFAULT_NIGHT_COUNT;
    }

    emit(state.copyWith(
      nightCount: event.nightCount,
      validNightCount: isValid,
      nightClothes: int.parse(nightCount),
    ));
  }

  void _onHomeResetValues(
    HomeResetValues event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      page: HomeState.DEFAULT_PAGE,
      dayCount: HomeState.DEFAULT_DAY_COUNT,
      validDayCount: HomeState.DEFAULT_VALID_DAY_COUNT,
      nightCount: HomeState.DEFAULT_NIGHT_COUNT,
      validNightCount: HomeState.DEFAULT_VALID_NIGHT_COUNT,
      dayClothes: HomeState.DEFAULT_DAY_CLOTHES,
      nightClothes: HomeState.DEFAULT_NIGHT_CLOTHES,
      underwear: HomeState.DEFAULT_UNDERWEAR,
      activities:
          state.activities.toList().map((e) => e.copyWith(isSelected: false)),
    ));
  }

  void _onHomeEditNotes(
    HomeEditNotes event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isEditingNotes: true));
  }

  Future<void> _onHomeSaveNotes(
    HomeSaveNotes event,
    Emitter<HomeState> emit,
  ) async {
    await _saveNotes.invoke(state.notes);
    emit(state.copyWith(isEditingNotes: false));
  }

  void _onHomeNotesChanged(
    HomeNotesChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));
  }

  Future<void> _onHomeAddActivity(
    HomeAddActivity event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final newActivity = Activity(name: event.name, note: '');

      await _saveActivity.invoke(newActivity);

      final activities = state.activities.toList();
      activities.add(ActivityState(
        activity: newActivity,
        isEditable: false,
        isSelected: true,
      ));

      emit(state.copyWith(activities: activities));
    } on DuplicateError {
      _showDuplicateActivity.add(event.name);
    } on NullThrownError {
      _showEmptyActivity.add(null);
    }
  }

  Future<void> _onHomeDeleteActivity(
    HomeDeleteActivity event,
    Emitter<HomeState> emit,
  ) async {
    await _deleteActivity.invoke(event.name);

    final activities = state.activities.toList();

    final activityToDelete = _findActivityIndex(event.name);

    activities.removeAt(activityToDelete);

    emit(state.copyWith(activities: activities));
  }

  void _onHomeEditActivityNote(
    HomeEditActivityNote event,
    Emitter<HomeState> emit,
  ) {
    final activities = state.activities.toList();

    final indexOfActivityToEdit = _findActivityIndex(event.name);
    final activityToEdit = activities[indexOfActivityToEdit];

    activities[activities.indexOf(activityToEdit)] =
        activityToEdit.copyWith(isEditable: true);

    emit(state.copyWith(activities: activities));
  }

  Future<void> _onHomeSaveActivityNote(
    HomeSaveActivityNote event,
    Emitter<HomeState> emit,
  ) async {
    final activities = state.activities.toList();

    final indexOfActivityToEdit = _findActivityIndex(event.name);
    final activityToEdit = activities[indexOfActivityToEdit];

    await _updateActivityNote.invoke(activityToEdit.activity);

    activities[activities.indexOf(activityToEdit)] =
        activityToEdit.copyWith(isEditable: false);

    emit(state.copyWith(activities: activities));
  }

  void _onHomeActivityNoteChanged(
    HomeActivityNoteChanged event,
    Emitter<HomeState> emit,
  ) {
    final activities = state.activities.toList();

    final indexOfActivityToEdit = _findActivityIndex(event.name);
    final activityToEdit = activities[indexOfActivityToEdit];

    final updatedActivity = activityToEdit.activity.copyWith(note: event.note);

    activities[indexOfActivityToEdit] =
        activityToEdit.copyWith(activity: updatedActivity);

    emit(state.copyWith(activities: activities));
  }

  void _onHomeActivityToggle(
    HomeActivityToggle event,
    Emitter<HomeState> emit,
  ) {
    final activities = state.activities.toList();

    final indexOfActivityToEdit = _findActivityIndex(event.name);
    final activityToEdit = activities[indexOfActivityToEdit];

    activities[activities.indexOf(activityToEdit)] =
        activityToEdit.copyWith(isSelected: !activityToEdit.isSelected);

    emit(state.copyWith(
      activities: activities,
      dayClothes:
          int.parse(state.dayCount) + _countSelectedActivities(activities) - 1,
    ));
  }

  int _findActivityIndex(String activityName) {
    return state.activities.toList().indexWhere((activityState) =>
        activityState.activity.name.toLowerCase() ==
        activityName.toLowerCase());
  }

  int _countSelectedActivities(Iterable<ActivityState> activities) {
    return activities.where((activity) => activity.isSelected).length;
  }
}
