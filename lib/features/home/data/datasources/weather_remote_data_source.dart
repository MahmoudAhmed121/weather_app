import 'package:weather_app/core/export.dart';
import 'package:weather_app/features/home/export.dart';

// Interface for remote weather data operations
abstract class WeatherRemoteDataSource {
  // Fetches weather data from API for the specified city
  Future<WeatherModel> getWeatherData({required String city});
}

// Implementation of remote weather data operations
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiService _apiService;

  WeatherRemoteDataSourceImpl(this._apiService);

  @override
  Future<WeatherModel> getWeatherData({required String city}) async {
    // Call the API service to fetch weather data
    return await _apiService.getWeatherData(
      ApiConstants.apiKey,
      city,
    );
  }
}
