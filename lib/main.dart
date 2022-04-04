import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'home_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: HomeObserver(),
  );
}
