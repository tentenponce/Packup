import 'dart:async';

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
  StreamSubscription? _subShowDuplicateActivity;
  String? _activityName;

  @override
  void initState() {
    super.initState();

    _subShowDuplicateActivity =
        context.read<HomeBloc>().showDuplicateActivity.listen((activity) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('$activity already exists.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    _subShowDuplicateActivity?.cancel();
    super.dispose();
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
                  _displayAddActivityDialog(context);
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

            /// build activity list
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  children: state.activities.map((activity) {
                    return Row(children: [
                      Checkbox(
                          value: false,
                          onChanged: (bool) {
                            // TODO: select/deselect activity
                          }),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(activity.name),
                        ),
                      ),
                      UIIcon(
                        width: grid_8,
                        height: grid_8,
                        asset: 'assets/ic_edit.svg',
                        onPressed: () {
                          // TODO: add notes
                        },
                      ),
                      SizedBox(width: space_xxs),
                      UIIcon(
                        width: grid_10,
                        height: grid_10,
                        asset: 'assets/ic_close.svg',
                        onPressed: () {
                          context
                              .read<HomeBloc>()
                              .add(HomeDeleteActivity(activity.name));
                        },
                      ),
                    ]);
                  }).toList(),
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

  Future<void> _displayAddActivityDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('What activity do you want to add?'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _activityName = value;
                });
              },
              controller: null,
              decoration: InputDecoration(hintText: 'put activity name here'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  this
                      .context
                      .read<HomeBloc>()
                      .add(HomeAddActivity(_activityName ?? ''));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
