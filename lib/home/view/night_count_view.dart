import 'package:flutter/material.dart';

class NightCountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Packup')),
      body: Center(
        child: Text('Night Count View', style: textTheme.headline2),
      ),
    );
  }
}
