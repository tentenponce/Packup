import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/home/bloc/home_bloc.dart';

import '../home.dart';
import 'day_count_view.dart';
import 'night_count_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) => {},
      child: Scaffold(
        body: Center(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              var view;
              switch (state.page) {
                case HomePages.dayCount:
                  view = DayCountView();
                  break;
                case HomePages.nightCount:
                  view = NightCountView();
                  break;
                case HomePages.activityCount:
                  view = DayCountView();
                  break;
                case HomePages.summary:
                  view = DayCountView();
                  break;
              }

              return view;
            },
          ),
        ),
      ),
    );
  }
}
