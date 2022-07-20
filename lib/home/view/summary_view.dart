import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/components/ui_icon.dart';
import 'package:packup/res/dimens.dart';

import '../home.dart';

class SummaryView extends StatelessWidget {
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
              'Summary',
              style: TextStyle(
                fontSize: text_huge,
              ),
            ),
            SizedBox(height: space_m),
            Container(
              padding: EdgeInsets.all(space_l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Day clothes:',
                          style: TextStyle(
                            fontSize: text_m,
                          ),
                        ),
                        SizedBox(height: space_s),
                        Text(
                          'Night clothes:',
                          style: TextStyle(
                            fontSize: text_m,
                          ),
                        ),
                        SizedBox(height: space_s),
                        Text(
                          'Underwear:',
                          style: TextStyle(
                            fontSize: text_m,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          context.read<HomeBloc>().state.dayClothes.toString(),
                          style: TextStyle(
                            fontSize: text_m,
                          ),
                        ),
                        SizedBox(height: space_s),
                        Text(
                          context
                              .read<HomeBloc>()
                              .state
                              .nightClothes
                              .toString(),
                          style: TextStyle(
                            fontSize: text_m,
                          ),
                        ),
                        SizedBox(height: space_s),
                        Text(
                          context.read<HomeBloc>().state.underwear.toString(),
                          style: TextStyle(
                            fontSize: text_m,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // show activities only if there's atleast 1 activity
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state.activities.where((e) => e.isSelected).isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(
                            left: space_l, right: space_l, bottom: space_l),
                        width: double.infinity,
                        child: Text(
                          'Activities:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: text_l,
                          ),
                        ),
                      )
                    : Container();
              },
            ),
            // activity list
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final selectedActivities = state.activities
                    .where((e) => e.isSelected)
                    .map((e) => e.activity);

                return Container(
                  padding: EdgeInsets.only(left: space_l, right: space_m),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedActivities
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(fontSize: text_s),
                                ),
                                SizedBox(height: space_xxs),
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  initialValue: e.note ?? '',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                SizedBox(height: space_m),
                              ],
                            ))
                        .toList(),
                  ),
                );
              },
            ),
            // general note actions
            SizedBox(height: space_l),
            Container(
              margin: EdgeInsets.only(left: space_l, right: space_l),
              width: double.infinity,
              child: Text(
                'General Notes:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: text_l,
                ),
              ),
            ),
            SizedBox(height: space_m),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: space_l, right: space_l),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return UIIcon(
                    asset: state.isEditingNotes
                        ? 'assets/ic_check.svg'
                        : 'assets/ic_edit.svg',
                    height: grid_7,
                    width: grid_7,
                    onPressed: () {
                      state.isEditingNotes
                          ? context.read<HomeBloc>().add(HomeSaveNotes())
                          : context.read<HomeBloc>().add(HomeEditNotes());
                    },
                  );
                },
              ),
            ),
            // general note
            Container(
              padding: EdgeInsets.fromLTRB(space_l, space_s, space_l, space_l),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    initialValue: context.read<HomeBloc>().state.notes,
                    onChanged: (text) =>
                        context.read<HomeBloc>().add(HomeNotesChanged(text)),
                    enabled: state.isEditingNotes,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'Notes',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: space_m),
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
                    child: Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(space_l),
                    ),
                    onPressed: () =>
                        context.read<HomeBloc>().add(HomeResetValues()),
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
