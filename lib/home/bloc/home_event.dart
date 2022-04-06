part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeNextPage extends HomeEvent {
  const HomeNextPage();
}

class HomePreviousPage extends HomeEvent {
  const HomePreviousPage();
}

class HomeDayCountChanged extends HomeEvent {
  const HomeDayCountChanged(this.dayCount);

  final String dayCount;

  @override
  List<Object> get props => [dayCount];
}
