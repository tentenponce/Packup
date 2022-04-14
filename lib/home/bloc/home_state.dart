part of 'home_bloc.dart';

enum HomePages { dayCount, nightCount, activityCount, summary }

var pageOrder = [
  HomePages.dayCount,
  HomePages.nightCount,
  HomePages.activityCount,
  HomePages.summary,
];

class HomeState extends Equatable {
  static const DEFAULT_PAGE = HomePages.dayCount;
  static const DEFAULT_DAY_COUNT =
      '3'; // most of our trips is 3 days long. Agree? lol
  static const DEFAULT_VALID_DAY_COUNT = true;
  static const DEFAULT_NIGHT_COUNT =
      '2'; // most of our trips is 2 nights long. Agree? lol
  static const DEFAULT_VALID_NIGHT_COUNT = true;

  const HomeState({
    this.page = DEFAULT_PAGE,
    this.dayCount = DEFAULT_DAY_COUNT,
    this.validDayCount = DEFAULT_VALID_DAY_COUNT,
    this.nightCount = DEFAULT_NIGHT_COUNT,
    this.validNightCount = DEFAULT_VALID_NIGHT_COUNT,
  });

  final HomePages page;
  final String dayCount;
  final bool validDayCount;
  final String nightCount;
  final bool validNightCount;

  HomeState copyWith({
    HomePages? page,
    String? dayCount,
    bool? validDayCount,
    String? nightCount,
    bool? validNightCount,
  }) {
    return HomeState(
      page: page ?? this.page,
      dayCount: dayCount ?? this.dayCount,
      validDayCount: validDayCount ?? this.validDayCount,
      nightCount: nightCount ?? this.nightCount,
      validNightCount: validNightCount ?? this.validNightCount,
    );
  }

  @override
  List<Object> get props => [
        page,
        dayCount,
        validDayCount,
        nightCount,
        validNightCount,
      ];
}
