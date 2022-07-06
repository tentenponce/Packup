import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/errors/duplicate_error.dart';
import 'package:domain/interactor/activity/delete_activity.dart';
import 'package:domain/interactor/activity/get_activities.dart';
import 'package:domain/interactor/activity/save_activity.dart';
import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:domain/model/activity.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetNotes getNotes,
    required SaveNotes saveNotes,
    required GetActivities getActivities,
    required SaveActivity saveActivity,
    required DeleteActivity deleteActivity,
  })  : _getNotes = getNotes,
        _saveNotes = saveNotes,
        _getActivities = getActivities,
        _saveActivity = saveActivity,
        _deleteActivity = deleteActivity,
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
    on<HomeDeleteActivity>(_onHomeDeleteActivity);
  }

  final GetNotes _getNotes;
  final SaveNotes _saveNotes;
  final GetActivities _getActivities;
  final SaveActivity _saveActivity;
  final DeleteActivity _deleteActivity;

  /* one time events */
  Stream<String> get showDuplicateActivity => _showDuplicateActivity.stream;
  final _showDuplicateActivity = StreamController<String>.broadcast();

  @override
  Future<void> close() {
    _showDuplicateActivity.close();
    return super.close();
  }

  Future<void> _onHomeInit(
    HomeInit event,
    Emitter<HomeState> emit,
  ) async {
    final activities = await _getActivities.invoke();

    emit(state.copyWith(activities: activities));
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

    /// TODO
    emit(state.copyWith(
      dayCount: event.dayCount,
      validDayCount: isValid,
      dayClothes: int.parse(dayCount) - 1,
      underwear: int.parse(dayCount) - 1,
      // dayClothes: int.parse(dayCount) + int.parse(state.activityCount) - 1,
      // underwear: int.parse(dayCount) + int.parse(state.activityCount) - 1,
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
      final newActivity = Activity(event.name, '');

      await _saveActivity.invoke(newActivity);

      final activities = state.activities.toList();
      activities.add(newActivity);

      emit(state.copyWith(activities: activities));
    } on DuplicateError {
      _showDuplicateActivity.add(event.name);
    }
  }

  Future<void> _onHomeDeleteActivity(
    HomeDeleteActivity event,
    Emitter<HomeState> emit,
  ) async {
    await _deleteActivity.invoke(event.name);

    final activities = state.activities.toList();

    final activityToDelete = activities
        .where((activity) =>
            activity.name.toLowerCase() == event.name.toLowerCase())
        .first;

    activities.remove(activityToDelete);

    emit(state.copyWith(activities: activities));
  }
}
