import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/res/dimens.dart';

import '../home.dart';

class ActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(space_m),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: space_xxxl),
            Text(
              'How many activities that require clothes?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: text_huge,
              ),
            ),
            SizedBox(height: space_m),
            Text(
              'Example: Swimming, Hiking, etc.',
              style: TextStyle(
                fontSize: text_s,
              ),
            ),
            SizedBox(height: space_xxxl),
            Container(
              width: grid_30,
              child: TextFormField(
                initialValue: context.read<HomeBloc>().state.activityCount,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (text) => context
                    .read<HomeBloc>()
                    .add(HomeActivityCountChanged(text)),
                style: TextStyle(
                  fontSize: text_very_huge,
                ),
              ),
            ),
            SizedBox(height: space_m),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Visibility(
                  child: Text(
                    'Invalid value',
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: !state.validActivityCount,
                );
              },
            ),
            SizedBox(height: space_xxxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: grid_30,
                  child: OutlinedButton(
                    child: Text('Back'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(space_l),
                    ),
                    onPressed: () =>
                        context.read<HomeBloc>().add(HomePreviousPage()),
                  ),
                ),
                SizedBox(width: space_m),
                Container(
                  width: grid_30,
                  child: ElevatedButton(
                    child: Text('Next'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(space_l),
                    ),
                    onPressed: () =>
                        context.read<HomeBloc>().add(HomeNextPage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
