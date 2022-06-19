import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'app_observer.dart';

import 'package:packup/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  BlocOverrides.runZoned(
    () => runApp(App()),
    blocObserver: AppObserver(),
  );
}
