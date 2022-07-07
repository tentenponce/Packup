part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInit extends HomeEvent {
  const HomeInit();
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

class HomeAddActivity extends HomeEvent {
  const HomeAddActivity(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class HomeEditActivityNote extends HomeEvent {
  const HomeEditActivityNote(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class HomeDeleteActivity extends HomeEvent {
  const HomeDeleteActivity(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class HomeSaveActivityNote extends HomeEvent {
  const HomeSaveActivityNote(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class HomeActivityNoteChanged extends HomeEvent {
  const HomeActivityNoteChanged(this.name, this.note);

  final String name;
  final String note;

  @override
  List<Object> get props => [name, note];
}

class HomeActivityToggle extends HomeEvent {
  const HomeActivityToggle(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
