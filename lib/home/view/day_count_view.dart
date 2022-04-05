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
          children: [
            TextField(
              onChanged: (text) => context
                  .read<HomeBloc>()
                  .add(HomeDayCountChanged(int.parse(text))),
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