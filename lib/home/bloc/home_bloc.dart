import 'package:bloc/bloc.dart';
import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetNotes getNotes,
    required SaveNotes saveNotes,
  })  : _getNotes = getNotes,
        _saveNotes = saveNotes,
        super(HomeState()) {
    on<HomeNextPage>(_onHomeNextPage);
    on<HomePreviousPage>(_onHomePreviousPage);
    on<HomeDayCountChanged>(_onHomeDayCountChanged);
    on<HomeNightCountChanged>(_onHomeNightCountChanged);
    on<HomeActivityCountChanged>(_onHomeActivityCountChanged);
    on<HomeResetValues>(_onHomeResetValues);
    on<HomeEditNotes>(_onHomeEditNotes);
    on<HomeSaveNotes>(_onHomeSaveNotes);
    on<HomeNotesChanged>(_onHomeNotesChanged);
  }

  final GetNotes _getNotes;
  final SaveNotes _saveNotes;

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

      if (state.page == HomePages.activityCount && !state.validActivityCount) {
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
      dayClothes: int.parse(dayCount) + int.parse(state.activityCount) - 1,
      underwear: int.parse(dayCount) + int.parse(state.activityCount) - 1,
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

  void _onHomeActivityCountChanged(
    HomeActivityCountChanged event,
    Emitter<HomeState> emit,
  ) {
    var isValid = RegExp(r'^[0-9]+$').hasMatch(event.activityCount);

    var activityCount = event.activityCount;
    if (!isValid) {
      activityCount = HomeState.DEFAULT_ACTIVITY_COUNT;
    }

    emit(state.copyWith(
      activityCount: event.activityCount,
      validActivityCount: isValid,
      dayClothes: int.parse(state.dayCount) + int.parse(activityCount) - 1,
      underwear: int.parse(state.dayCount) + int.parse(activityCount) - 1,
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
      activityCount: HomeState.DEFAULT_ACTIVITY_COUNT,
      validActivityCount: HomeState.DEFAULT_VALID_ACTIVITY_COUNT,
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
}
