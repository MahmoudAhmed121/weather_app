import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/cubit/internet/internet_cubit.dart';
import 'package:weather_app/core/networking/api_service.dart';
import 'package:weather_app/core/networking/dio_factory.dart';
import 'package:weather_app/features/home/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/home/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/repos/weather_repository.dart';
import 'package:weather_app/features/home/presentation/cubits/weather/weather_cubit.dart';

class ServicesLocator {
  static final GetIt locator = GetIt.instance;

  static void setup() {
    // Dio & ApiService
    final Dio dio = DioFactory.getDio();
    locator.registerLazySingleton<ApiService>(() => ApiService(dio));

    // internet
    locator.registerLazySingleton<InternetCubit>(() => InternetCubit());

    // Data sources
    locator.registerLazySingleton<WeatherLocalDataSource>(() => WeatherLocalDataSourceImpl());
    locator.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(locator<ApiService>()));

    // Repositories
    locator.registerLazySingleton<WeatherRepository>(() => WeatherRepository(locator<WeatherRemoteDataSource>(),locator<WeatherLocalDataSource>()));

    // Cubits
    locator.registerFactory<WeatherCubit>(() => WeatherCubit(locator<WeatherRepository>()));
  }
 
  static InternetCubit get internetCubit => locator<InternetCubit>();
  static WeatherCubit get weatherCubit => locator<WeatherCubit>();
  
}
