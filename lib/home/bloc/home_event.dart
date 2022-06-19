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

class HomeNightCountChanged extends HomeEvent {
  const HomeNightCountChanged(this.nightCount);

  final String nightCount;

  @override
  List<Object> get props => [nightCount];
}

class HomeActivityCountChanged extends HomeEvent {
  const HomeActivityCountChanged(this.activityCount);

  final String activityCount;

  @override
  List<Object> get props => [activityCount];
}

class HomeResetValues extends HomeEvent {
  const HomeResetValues();
}

class HomeNotesChanged extends HomeEvent {
  const HomeNotesChanged(this.notes);

  final String notes;

  @override
  List<Object> get props => [notes];
}

class HomeEditNotes extends HomeEvent {
  const HomeEditNotes();
}

class HomeSaveNotes extends HomeEvent {
  const HomeSaveNotes();
}
