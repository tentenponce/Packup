import 'package:bloc/bloc.dart';

enum HomePages { dayCount, nightCount, activityCount, summary }

class HomeCubit extends Cubit<HomePages> {
  var pageOrder = [
    HomePages.dayCount,
    HomePages.nightCount,
    HomePages.activityCount,
    HomePages.summary,
  ];

  HomeCubit() : super(HomePages.dayCount);

  void nextPage() {
    var currentPageIndex = pageOrder.indexOf(state);

    if (currentPageIndex < pageOrder.length - 1) {
      emit(pageOrder[currentPageIndex + 1]);
    }
  }

  void previousPage() {
    var currentPageIndex = pageOrder.indexOf(state);

    if (currentPageIndex > 0) {
      emit(pageOrder[currentPageIndex - 1]);
    }
  }
}
