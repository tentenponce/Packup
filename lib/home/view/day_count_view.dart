import 'package:flutter/material.dart';

class DayCountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Packup')),
      body: Center(
        child: Text('Day Count View', style: textTheme.headline2),
      ),
    );
  }
}
