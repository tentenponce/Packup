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
  static const DEFAULT_ACTIVITY_COUNT =
      '1'; // most of our trips has swimming. Agree? lol
  static const DEFAULT_VALID_ACTIVITY_COUNT = true;
  static const DEFAULT_DAY_CLOTHES = 4;
  static const DEFAULT_NIGHT_CLOTHES = 2;
  static const DEFAULT_UNDERWEAR = 4;

  const HomeState({
    this.page = DEFAULT_PAGE,
    this.dayCount = DEFAULT_DAY_COUNT,
    this.validDayCount = DEFAULT_VALID_DAY_COUNT,
    this.nightCount = DEFAULT_NIGHT_COUNT,
    this.validNightCount = DEFAULT_VALID_NIGHT_COUNT,
    this.activityCount = DEFAULT_ACTIVITY_COUNT,
    this.validActivityCount = DEFAULT_VALID_ACTIVITY_COUNT,
    this.dayClothes = DEFAULT_DAY_CLOTHES,
    this.nightClothes = DEFAULT_NIGHT_CLOTHES,
    this.underwear = DEFAULT_UNDERWEAR,
  });

  final HomePages page;
  final String dayCount;
  final bool validDayCount;
  final String nightCount;
  final bool validNightCount;
  final String activityCount;
  final bool validActivityCount;
  final int dayClothes;
  final int nightClothes;
  final int underwear;

  HomeState copyWith({
    HomePages? page,
    String? dayCount,
    bool? validDayCount,
    String? nightCount,
    bool? validNightCount,
    String? activityCount,
    bool? validActivityCount,
    int? dayClothes,
    int? nightClothes,
    int? underwear,
  }) {
    return HomeState(
      page: page ?? this.page,
      dayCount: dayCount ?? this.dayCount,
      validDayCount: validDayCount ?? this.validDayCount,
      nightCount: nightCount ?? this.nightCount,
      validNightCount: validNightCount ?? this.validNightCount,
      activityCount: activityCount ?? this.activityCount,
      validActivityCount: validActivityCount ?? this.validActivityCount,
      dayClothes: dayClothes ?? this.dayClothes,
      nightClothes: nightClothes ?? this.nightClothes,
      underwear: underwear ?? this.underwear,
    );
  }

  @override
  List<Object> get props => [
        page,
        dayCount,
        validDayCount,
        nightCount,
        validNightCount,
        activityCount,
        validActivityCount,
        dayClothes,
        nightClothes,
        underwear,
      ];
}
