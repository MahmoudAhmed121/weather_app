import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/export.dart';
import 'package:weather_app/features/auth/export.dart';
import 'package:weather_app/features/home/export.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashScreen();
          },
        );

      case homeScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => ServicesLocator.weatherCubit,
              child: const HomeScreen(),
            );
          },
        );
    }

    return null;
  }
}
