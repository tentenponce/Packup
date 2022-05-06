import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeNextPage>(_onHomeNextPage);
    on<HomePreviousPage>(_onHomePreviousPage);
    on<HomeDayCountChanged>(_onHomeDayCountChanged);
    on<HomeNightCountChanged>(_onHomeNightCountChanged);
    on<HomeActivityCountChanged>(_onHomeActivityCountChanged);
    on<HomeResetValues>(_onHomeResetValues);
  }

  void _onHomeNextPage(
    HomeNextPage event,
    Emitter<HomeState> emit,
  ) {
    var currentPageIndex = pageOrder.indexOf(state.page);

    if (currentPageIndex < pageOrder.length - 1 &&
        ((state.validDayCount && state.page == HomePages.dayCount) ||
            (state.validNightCount && state.page == HomePages.nightCount) ||
            (state.validActivityCount &&
                state.page == HomePages.activityCount) ||
            (state.page != HomePages.dayCount &&
                state.page != HomePages.nightCount &&
                state.page != HomePages.activityCount))) {
      emit(state.copyWith(page: pageOrder[currentPageIndex + 1]));
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
      dayClothes: int.parse(dayCount) + int.parse(state.activityCount),
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
      dayClothes: int.parse(state.dayCount) + int.parse(activityCount),
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
}
