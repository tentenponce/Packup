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
  StreamSubscription? _subShowEmptyActivity;
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

    _subShowEmptyActivity =
        context.read<HomeBloc>().showEmptyActivity.listen((activity) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Activity name cannot be empty.'),
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
    _subShowEmptyActivity?.cancel();
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
            /* build activity list */
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  children: state.activities.map((activityState) {
                    final activity = activityState.activity;
                    final isEditable = activityState.isEditable;
                    final isSelected = activityState.isSelected;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: isSelected,
                                onChanged: (bool) {
                                  context
                                      .read<HomeBloc>()
                                      .add(HomeActivityToggle(activity.name));
                                }),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(activity.name),
                              ),
                            ),
                            SizedBox(width: space_xxs),
                            UIIcon(
                              width: grid_10,
                              height: grid_10,
                              asset: isEditable
                                  ? 'assets/ic_check.svg'
                                  : 'assets/ic_edit.svg',
                              onPressed: () {
                                context.read<HomeBloc>().add(isEditable
                                    ? HomeSaveActivityNote(activity.name)
                                    : HomeEditActivityNote(activity.name));
                              },
                            ),
                            UIIcon(
                              width: grid_10,
                              height: grid_10,
                              asset: 'assets/ic_close.svg',
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text(
                                            'Delete ${activity.name} activity?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                              context
                                                  .read<HomeBloc>()
                                                  .add(HomeDeleteActivity(
                                                    activity.name,
                                                  ));
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                        /* notes per activity */
                        Container(
                          margin:
                              EdgeInsets.only(left: space_s, right: space_s),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            initialValue: activity.note,
                            enabled: isEditable,
                            onChanged: (text) => context.read<HomeBloc>().add(
                                HomeActivityNoteChanged(activity.name, text)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: 'Add notes for ${activity.name} here',
                            ),
                          ),
                        ),
                        SizedBox(height: space_s),
                      ],
                    );
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
