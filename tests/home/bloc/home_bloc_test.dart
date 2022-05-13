import 'package:packup/home/bloc/home_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = HomeBloc();
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
  });
}
