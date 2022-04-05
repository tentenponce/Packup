part of 'home_bloc.dart';

enum HomePages { dayCount, nightCount, activityCount, summary }

var pageOrder = [
  HomePages.dayCount,
  HomePages.nightCount,
  HomePages.activityCount,
  HomePages.summary,
];

class HomeState extends Equatable {
  const HomeState({
    this.page = HomePages.dayCount,
    this.dayCount = 3, // most of our trips is 3 days long. Agree? lol
  });

  final HomePages page;
  final int dayCount;

  HomeState copyWith({
    HomePages? page,
    int? dayCount,
  }) {
    return HomeState(
      page: page ?? this.page,
      dayCount: dayCount ?? this.dayCount,
    );
  }

  @override
  List<Object> get props => [page, dayCount];
}
