import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/export.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final RouteLogger routeLogger;

  const MyApp({
    super.key,
    required this.appRouter,
    required this.routeLogger,
  });

  @override
  Widget build(BuildContext context) {
    return buildAppWithProviders(
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            routeLogger,
          ],
          title: 'Weather App',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.backGroundColor,
            textTheme: GoogleFonts.cairoTextTheme(),
            primaryColor: AppColor.primaryColor,
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
