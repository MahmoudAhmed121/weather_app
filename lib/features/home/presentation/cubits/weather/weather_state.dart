import 'package:equatable/equatable.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

enum WeatherStatus { initial, loading, loaded, error, cached}

class WeatherState extends Equatable {
  final WeatherStatus? status;
  final WeatherModel? weatherData;
  final String? errorMessage;

  const WeatherState({
    this.status,
    this.weatherData,
    this.errorMessage,
  });

  static const WeatherState initial = WeatherState(
    status: WeatherStatus.initial,
    weatherData: null,
    errorMessage: null,
  );

  WeatherState loading() => copyWith(status: WeatherStatus.loading);
  WeatherState loaded(WeatherModel weatherData) =>
      copyWith(status: WeatherStatus.loaded, weatherData: weatherData);
  WeatherState error(String errorMessage) =>
      copyWith(status: WeatherStatus.error, errorMessage: errorMessage);
  WeatherState cached(WeatherModel weatherData) =>
      copyWith(status: WeatherStatus.cached, weatherData: weatherData);

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherModel? weatherData,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherData: weatherData ?? this.weatherData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, weatherData, errorMessage];

  @override
  String toString() {
    return 'WeatherState(status: $status, weatherData: $weatherData, errorMessage: $errorMessage)';
  }
}
