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
    this.dayCount = '3', // most of our trips is 3 days long. Agree? lol
    this.validDayCount = true,
  });

  final HomePages page;
  final String dayCount;
  final bool validDayCount;

  HomeState copyWith({
    HomePages? page,
    String? dayCount,
    bool? validDayCount,
  }) {
    return HomeState(
      page: page ?? this.page,
      dayCount: dayCount ?? this.dayCount,
      validDayCount: validDayCount ?? this.validDayCount,
    );
  }

  @override
  List<Object> get props => [page, dayCount, validDayCount];
}
