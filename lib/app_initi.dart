import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/core/utils/bloc_observer.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

import 'core/services/locator/get_it_locator.dart';
import 'core/utils/cache/cache_helper.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  registerWeatherAdapters();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await CacheHelper.init();

  ServicesLocator.setup();
  await ScreenUtil.ensureScreenSize();

  Bloc.observer = AppBlocObserver();
}

Future<void> init() async {
  await Hive.initFlutter();
  if (Platform.isIOS) {
    final dir = await getApplicationDocumentsDirectory();
    final hiveDir = Directory(dir.path);
    if (await hiveDir.exists()) {
      try {
        await Process.run(
          'xattr',
          [
            '-w',
            'com. apple MobileBackup',
            '1',
            hiveDir.path,
          ],
        );
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
