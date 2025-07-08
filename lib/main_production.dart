import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/app_initi.dart';

import 'core/navigation/app_router.dart';
import 'core/utils/route_observer.dart';

void main() async {
  runZonedGuarded(
    () async {
      await initializeApp();

      runApp(MyApp(appRouter: AppRouter(), routeLogger: RouteLogger()));
    },
    (error, stack) {
      log(stack.toString(), name: 'main production error');
    },
  );
}
