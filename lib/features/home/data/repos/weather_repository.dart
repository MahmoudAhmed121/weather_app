import 'package:dio/dio.dart';
import 'package:weather_app/core/networking/api_error_handler.dart';
import 'package:weather_app/core/networking/api_result.dart';
import 'package:weather_app/features/home/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/home/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

// Weather Repository: Coordinates data retrieval from remote and local sources
class WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;

  WeatherRepository(this._remoteDataSource, this._localDataSource);

  // Fetches weather data from API and caches it locally
  Future<ApiResult<WeatherModel>> getWeatherData(String city) async {
    try {
      final weatherData = await _remoteDataSource.getWeatherData(city: city);
      await _localDataSource.cacheWeatherData(weatherData);
      return ApiResult.success(weatherData);
    } on DioException catch (e) {
      return ApiResult.failure(ServerFailure.fromDioError(e));
    }
  }

  // Retrieves previously cached weather data from local storage
  Future<ApiResult<WeatherModel>> getCachedWeatherData() async {
    try {
      final weatherData = await _localDataSource.getLastWeatherData();

      if (weatherData != null) {
        return ApiResult.success(weatherData);
      } else {
        return ApiResult.failure(ServerFailure('No data found'));
      }
    } catch (e) {
      return ApiResult.failure(
          ServerFailure('Error retrieving cached data: ${e.toString()}'));
    }
  }
}
