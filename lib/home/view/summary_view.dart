import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packup/res/dimens.dart';

import '../home.dart';

class SummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
