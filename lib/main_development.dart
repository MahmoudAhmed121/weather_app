import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/core/export.dart';
import 'app_initi.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);

    logFlutterError(details);
  };
  runZonedGuarded(
    () async {
      await initializeApp();

      runApp(
        MyApp(
          appRouter: AppRouter(),
          routeLogger: RouteLogger(),
        ),
      );
    },
    (error, stackTrace) {
      logDartError(error, stackTrace);
      log(stackTrace.toString(), name: 'main');
    },
  );
}

void logFlutterError(FlutterErrorDetails details) {
  debugPrint('M.a.H.m.O.u.D Flutter Error: ${details.exception}');
  debugPrint('M.a.H.m.O.u.D Stack trace: ${details.stack}');
}

void logDartError(Object error, StackTrace stackTrace) {
  debugPrint('M.a.H.m.O.u.D Dart Error: $error');
  debugPrint('M.a.H.m.O.u.D Stack trace: $stackTrace');
}
