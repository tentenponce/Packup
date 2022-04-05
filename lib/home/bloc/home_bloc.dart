import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeNextPage>(_onHomeNextPage);
    on<HomePreviousPage>(_onHomePreviousPage);
    on<HomeDayCountChanged>(_onHomeDayCountChanged);
  }

  void _onHomeNextPage(
    HomeNextPage event,
    Emitter<HomeState> emit,
  ) {
    var currentPageIndex = pageOrder.indexOf(state.page);

    if (currentPageIndex < pageOrder.length - 1) {
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
    emit(state.copyWith(dayCount: event.dayCount));
  }
}
