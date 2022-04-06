import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class DayCountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Packup')),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (text) =>
                  context.read<HomeBloc>().add(HomeDayCountChanged(text)),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Visibility(
                  child: Text('Invalid value'),
                  visible: !state.validDayCount,
                );
              },
            ),
            TextButton(
              child: Text('Day Count View'),
              onPressed: () => context.read<HomeBloc>().add(HomeNextPage()),
            ),
          ],
        ),
      ),
    );
  }
}
