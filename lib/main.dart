import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/app.dart';
import 'package:flutter_app3/bloc_observer.dart';
import 'package:flutter_app3/injection_container.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
