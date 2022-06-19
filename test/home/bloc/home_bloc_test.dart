import 'package:domain/interactor/get_notes.dart';
import 'package:domain/interactor/save_notes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:packup/home/bloc/home_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetNotes, SaveNotes])
void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockGetNotes getNotes;
    late MockSaveNotes saveNotes;

    setUp(() {
      getNotes = MockGetNotes();
      saveNotes = MockSaveNotes();
      when(saveNotes.invoke(any)).thenAnswer((_) => Future.value(null));
      when(getNotes.invoke()).thenAnswer((_) => Future.value('test notes'));
      homeBloc = HomeBloc(getNotes: getNotes, saveNotes: saveNotes);
    });

    blocTest(
      'should validate day page properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('3'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        HomeState(page: HomePages.dayCount),
        isA<HomeState>().having(
            (state) => state.page, 'night count page', HomePages.nightCount)
      ],
    );

    blocTest(
      'should not proceed and show invalid day page value',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('asd'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        isA<HomeState>()
            .having((state) => state.page, 'day count page', HomePages.dayCount)
            .having((state) => state.validDayCount, 'invalid day count', false)
      ],
    );

    blocTest(
      'should validate night page properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('3'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('2'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        HomeState(page: HomePages.dayCount),
        HomeState(page: HomePages.nightCount),
        isA<HomeState>().having((state) => state.page, 'activity count page',
            HomePages.activityCount)
      ],
    );

    blocTest(
      'should validate night page properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('3'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('asd'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        HomeState(page: HomePages.dayCount),
        HomeState(page: HomePages.nightCount),
        isA<HomeState>()
            .having((state) => state.page, 'nightCount count page',
                HomePages.nightCount)
            .having(
                (state) => state.validNightCount, 'invalid night count', false)
      ],
    );

    blocTest(
      'should validate activity page properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('3'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('2'));
        bloc.add(HomeNextPage());
        bloc.add(HomeActivityCountChanged('1'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        HomeState(page: HomePages.dayCount),
        HomeState(page: HomePages.nightCount),
        HomeState(page: HomePages.activityCount),
        isA<HomeState>()
            .having((state) => state.page, 'summary page', HomePages.summary)
      ],
    );

    blocTest(
      'should validate activity page properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('3'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('2'));
        bloc.add(HomeNextPage());
        bloc.add(HomeActivityCountChanged('asd'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        HomeState(page: HomePages.dayCount),
        HomeState(page: HomePages.nightCount),
        HomeState(page: HomePages.activityCount),
        isA<HomeState>()
            .having((state) => state.page, 'activity count page',
                HomePages.activityCount)
            .having((state) => state.validActivityCount,
                'invalid activity count', false)
      ],
    );

    blocTest(
      'should compute clothes properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('5'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('4'));
        bloc.add(HomeNextPage());
        bloc.add(HomeActivityCountChanged('2'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
            (state) => state.page, 'day count page', HomePages.dayCount),
        isA<HomeState>().having(
            (state) => state.page, 'night count page', HomePages.nightCount),
        isA<HomeState>().having(
            (state) => state.page, 'night count page', HomePages.nightCount),
        isA<HomeState>().having((state) => state.page, 'activity count page',
            HomePages.activityCount),
        isA<HomeState>().having((state) => state.page, 'activity count page',
            HomePages.activityCount),
        isA<HomeState>()
            .having((state) => state.dayClothes, 'day clothes', 6)
            .having((state) => state.nightClothes, 'night clothes', 4)
            .having((state) => state.underwear, 'underwear', 6)
      ],
    );

    blocTest(
      'should get notes on summary page',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('5'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('4'));
        bloc.add(HomeNextPage());
        bloc.add(HomeActivityCountChanged('2'));
        bloc.add(HomeNextPage());
      },
      verify: (_) {
        verify(getNotes.invoke()).called(1);
      },
    );

    blocTest(
      'should reset values succesfully',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeResetValues());
      },
      expect: () => <dynamic>[
        HomeState(
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
        ),
      ],
    );

    blocTest(
      'should change notes succesfully',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeNotesChanged('some test notes'));
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.notes,
          'notes',
          'some test notes',
        ),
      ],
    );

    blocTest(
      'should save notes succesfully',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeNotesChanged('some test notes'));
        bloc.add(HomeSaveNotes());
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.notes,
          'notes',
          'some test notes',
        ),
      ],
      verify: (_) => {verify(saveNotes.invoke('some test notes')).called(1)},
    );
  });
}
