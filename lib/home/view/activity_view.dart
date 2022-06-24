import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/components/ui_icon.dart';
import 'package:packup/res/dimens.dart';

import '../home.dart';

class ActivityView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActivityViewState();
  }
}

class ActivityViewState extends State<ActivityView> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().stream.listen((state) {
      if (state.prompt?.first == HomePrompt.duplicateActivity) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('${state.prompt?.last} already exists.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('OK'),
                  ),
                ],
              );
            });
      }
    });
  }

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
              'Check the activities included in your trip',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: text_huge,
              ),
            ),
            SizedBox(height: space_m),
            Text(
              'You can add/delete activities and add notes per activity.',
              style: TextStyle(
                fontSize: text_s,
              ),
            ),
            SizedBox(height: space_xl),
            Container(
              alignment: Alignment.centerRight,
              child: UIIcon(
                width: grid_10,
                height: grid_10,
                asset: 'assets/ic_add.svg',
                onPressed: () {
                  context.read<HomeBloc>().add(HomeAddActivity('Hiking'));
                },
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  children: [],
                );
              },
            ),
            SizedBox(height: space_m),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  children: state.activities.map((e) => Text(e.name)).toList(),
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
