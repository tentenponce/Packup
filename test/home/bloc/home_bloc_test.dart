import 'package:domain/errors/duplicate_error.dart';
import 'package:domain/interactor/activity/delete_activity.dart';
import 'package:domain/interactor/activity/get_activities.dart';
import 'package:domain/interactor/activity/save_activity.dart';
import 'package:domain/interactor/activity/update_activity_note.dart';
import 'package:domain/interactor/notes/get_notes.dart';
import 'package:domain/interactor/notes/save_notes.dart';
import 'package:domain/model/activity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:packup/home/bloc/home_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  GetNotes,
  SaveNotes,
  GetActivities,
  SaveActivity,
  DeleteActivity,
  UpdateActivityNote,
])
void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockGetNotes getNotes;
    late MockSaveNotes saveNotes;
    late MockGetActivities getActivities;
    late MockSaveActivity saveActivity;
    late MockDeleteActivity deleteActivity;
    late MockUpdateActivityNote updateActivityNote;

    setUp(() {
      getNotes = MockGetNotes();
      saveNotes = MockSaveNotes();
      getActivities = MockGetActivities();
      saveActivity = MockSaveActivity();
      deleteActivity = MockDeleteActivity();
      updateActivityNote = MockUpdateActivityNote();

      when(saveNotes.invoke(any)).thenAnswer((_) => Future.value(null));
      when(getNotes.invoke()).thenAnswer((_) => Future.value('test notes'));
      when(getActivities.invoke()).thenAnswer(
          (realInvocation) => Future.value([Activity(name: 'Swimming')]));

      homeBloc = HomeBloc(
        getNotes: getNotes,
        saveNotes: saveNotes,
        getActivities: getActivities,
        saveActivity: saveActivity,
        deleteActivity: deleteActivity,
        updateActivityNote: updateActivityNote,
      );
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
      'should compute clothes properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeDayCountChanged('5'));
        bloc.add(HomeNextPage());
        bloc.add(HomeNightCountChanged('4'));
        bloc.add(HomeNextPage());
        bloc.add(HomeActivityToggle('Swimming'));
        bloc.add(HomeNextPage());
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
            (state) => state.page, 'day count page', HomePages.dayCount),
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
            .having((state) => state.dayClothes, 'day clothes', 5)
            .having((state) => state.nightClothes, 'night clothes', 4)
            .having((state) => state.underwear, 'underwear', 9)
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

    test('should show duplicate activity if activity is duplicate', () async {
      when(saveActivity.invoke(any)).thenThrow(DuplicateError());

      homeBloc.add(HomeInit());
      homeBloc.add(HomeAddActivity('Swimming'));

      final result = await homeBloc.showDuplicateActivity.first;
      expect(result, 'Swimming');
    });

    test('should show empty name activity if returns empty error', () async {
      when(saveActivity.invoke(any)).thenThrow(NullThrownError());

      homeBloc.add(HomeInit());
      homeBloc.add(HomeAddActivity('Swimming'));

      expect(homeBloc.showEmptyActivity, emitsInOrder([null]));
    });

    blocTest(
      'should save activity properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeAddActivity('Hiking'));
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.activities.first.activity.name,
          'Swimming',
          'Swimming',
        ),
        isA<HomeState>().having(
          (state) => state.activities.elementAt(1).activity.name,
          'Hiking',
          'Hiking',
        ),
      ],
    );

    blocTest(
      'should go back to previous page successfully',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeDayCountChanged('1'));
        bloc.add(HomeNextPage());
        bloc.add(HomePreviousPage());
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
            (state) => state.page, 'day count page', HomePages.dayCount),
        isA<HomeState>().having(
            (state) => state.page, 'night count page', HomePages.nightCount),
        isA<HomeState>().having((state) => state.page, 'go back day count page',
            HomePages.dayCount),
      ],
    );

    blocTest(
      'should edit general note properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeEditNotes());
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
            (state) => state.isEditingNotes, 'editable notes true', true),
      ],
    );

    blocTest(
      'should delete activities properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeDeleteActivity('Swimming'));
      },
      expect: () => <dynamic>[
        isA<HomeState>()
            .having(
              (state) => state.activities.elementAt(0).activity.name,
              'swimming exists',
              'Swimming',
            )
            .having(
              (state) => state.activities.length,
              '1 activity',
              1,
            ),
        isA<HomeState>().having(
          (state) => state.activities.length,
          'no activity after delete',
          0,
        ),
      ],
      verify: (_) => {verify(deleteActivity.invoke('Swimming')).called(1)},
    );

    blocTest(
      'should save activity note properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeActivityNoteChanged('Swimming', 'slippers'));
        bloc.add(HomeSaveActivityNote('Swimming'));
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.activities.elementAt(0).activity.note,
          'no note',
          null,
        ),
        isA<HomeState>().having(
          (state) => state.activities.elementAt(0).activity.note,
          'notes added properly',
          'slippers',
        ),
        isA<HomeState>().having(
          (state) => state.activities.elementAt(0).isEditable,
          'disable editing after saving',
          false,
        ),
      ],
      verify: (_) {
        final verification = verify(updateActivityNote.invoke(captureAny));

        expect((verification.captured[0] as Activity).name, 'Swimming');
        expect((verification.captured[0] as Activity).note, 'slippers');

        verification.called(1);
      },
    );

    blocTest(
      'should edit activity properly',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeEditActivityNote('Swimming'));
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.activities.elementAt(0).isEditable,
          'note editable at first',
          false,
        ),
        isA<HomeState>().having(
          (state) => state.activities.elementAt(0).isEditable,
          'editable',
          true,
        ),
      ],
    );

    blocTest(
      'should update day clothes after adding activity',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeAddActivity('Hiking'));
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.dayClothes,
          'day clothes as is before adding',
          2,
        ),
        isA<HomeState>().having(
          (state) => state.dayClothes,
          'day clothes 3 after adding',
          3,
        ),
      ],
    );

    blocTest(
      'should pdate day clothes after deleting activity',
      build: () => homeBloc,
      act: (HomeBloc bloc) {
        bloc.add(HomeInit());
        bloc.add(HomeAddActivity('Hiking'));
        bloc.add(HomeDeleteActivity('Hiking'));
      },
      expect: () => <dynamic>[
        isA<HomeState>().having(
          (state) => state.dayClothes,
          'day clothes as is before adding',
          2,
        ),
        isA<HomeState>().having(
          (state) => state.dayClothes,
          'day clothes 3 after adding',
          3,
        ),
        isA<HomeState>().having(
          (state) => state.dayClothes,
          'day clothes 2 after deleting',
          2,
        ),
      ],
    );
  });
}
