import 'package:flutter/material.dart';

import 'home/home.dart';

class App extends MaterialApp {
  @override
  bool get debugShowCheckedModeBanner => false;
  const App({Key? key}) : super(key: key, home: const HomePage());
}
