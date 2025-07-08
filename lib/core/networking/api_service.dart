import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/core/networking/api_constants.dart';
import 'package:weather_app/core/networking/api_result.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiConstants.currentWeather)
  Future<WeatherModel> getWeatherData(
    @Query('key') String apiKey,
    @Query('q') String city,
  );
}
