import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            SizedBox(height: space_m),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(space_l, 0, 0, 0),
              child: UIIcon(
                asset: 'assets/ic_edit.svg',
                height: grid_7,
                width: grid_7,
                onPressed: () => {},
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(space_l, space_s, space_l, space_l),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Notes',
                ),
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
