import 'package:flutter/material.dart';

import 'home/home.dart';
import 'di.dart' as di;

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    di.init(context);

    return FutureBuilder(
      future: di.sl.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        } else {
          return Container(color: Colors.white);
        }
      },
    );
  }
}
