part of 'home_bloc.dart';

enum HomePages { dayCount, nightCount, activityCount, summary }

var pageOrder = [
  HomePages.dayCount,
  HomePages.nightCount,
  HomePages.activityCount,
  HomePages.summary,
];

@CopyWith()
class ActivityState {
  final Activity activity;
  final bool isEditable;
  final bool isSelected;

  const ActivityState({
    required this.activity,
    required this.isEditable,
    required this.isSelected,
  });
}

class HomeState extends Equatable {
  static const DEFAULT_PAGE = HomePages.dayCount;
  static const DEFAULT_DAY_COUNT =
      '3'; // most of our trips is 3 days long. Agree? lol
  static const DEFAULT_VALID_DAY_COUNT = true;
  static const DEFAULT_NIGHT_COUNT =
      '2'; // most of our trips is 2 nights long. Agree? lol
  static const DEFAULT_VALID_NIGHT_COUNT = true;
  static const DEFAULT_DAY_CLOTHES = 2;
  static const DEFAULT_NIGHT_CLOTHES = 2;
  static const DEFAULT_UNDERWEAR = 5;
  static const DEFAULT_IS_EDITING_NOTES = false;

  const HomeState({
    this.page = DEFAULT_PAGE,
    this.dayCount = DEFAULT_DAY_COUNT,
    this.validDayCount = DEFAULT_VALID_DAY_COUNT,
    this.nightCount = DEFAULT_NIGHT_COUNT,
    this.validNightCount = DEFAULT_VALID_NIGHT_COUNT,
    this.dayClothes = DEFAULT_DAY_CLOTHES,
    this.nightClothes = DEFAULT_NIGHT_CLOTHES,
    this.underwear = DEFAULT_UNDERWEAR,
    this.isEditingNotes = DEFAULT_IS_EDITING_NOTES,
    this.notes = '',
    this.activities = const Iterable.empty(),
  });

  final HomePages page;
  final String dayCount;
  final bool validDayCount;
  final String nightCount;
  final bool validNightCount;
  final int dayClothes;
  final int nightClothes;
  final int underwear;
  final bool isEditingNotes;
  final String notes;
  final Iterable<ActivityState> activities;

  HomeState copyWith({
    HomePages? page,
    String? dayCount,
    bool? validDayCount,
    String? nightCount,
    bool? validNightCount,
    String? activityCount,
    int? dayClothes,
    int? nightClothes,
    int? underwear,
    bool? isEditingNotes,
    String? notes,
    Iterable<ActivityState>? activities,
  }) {
    return HomeState(
      page: page ?? this.page,
      dayCount: dayCount ?? this.dayCount,
      validDayCount: validDayCount ?? this.validDayCount,
      nightCount: nightCount ?? this.nightCount,
      validNightCount: validNightCount ?? this.validNightCount,
      dayClothes: dayClothes ?? this.dayClothes,
      nightClothes: nightClothes ?? this.nightClothes,
      underwear: underwear ?? this.underwear,
      isEditingNotes: isEditingNotes ?? this.isEditingNotes,
      notes: notes ?? this.notes,
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object> get props => [
        page,
        dayCount,
        validDayCount,
        nightCount,
        validNightCount,
        dayClothes,
        nightClothes,
        underwear,
        isEditingNotes,
        notes,
        activities,
      ];
}
