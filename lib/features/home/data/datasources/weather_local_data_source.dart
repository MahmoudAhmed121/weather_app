import 'package:hive/hive.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

// Interface for local weather data operations
abstract class WeatherLocalDataSource {
  // Saves weather data to local storage
  Future<void> cacheWeatherData(WeatherModel weatherData);

  // Retrieves previously saved weather data from local storage
  Future<WeatherModel?> getLastWeatherData();
}

// Implementation of local weather data operations using Hive
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  static const String _weatherBoxName = 'weather_box';
  static const String _weatherKey = 'last_weather';

  @override
  Future<void> cacheWeatherData(WeatherModel weatherModel) async {
    final box = await Hive.openBox<WeatherModel>(_weatherBoxName);
    await box.put(_weatherKey, weatherModel);
  }

  @override
  Future<WeatherModel?> getLastWeatherData() async {
    final box = await Hive.openBox<WeatherModel>(_weatherBoxName);
    return box.get(_weatherKey);
  }
}
