import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/home/data/repos/weather_repository.dart';
import 'package:weather_app/features/home/presentation/cubits/weather/weather_state.dart';

// Weather Cubit: Manages weather data state and retrieval
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(
    this._weatherRepository,
  ) : super(WeatherState.initial);
  final TextEditingController cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Fetches weather data from API for the specified city
  Future<void> getWeatherData() async {
    emit(state.loading());

    final result = await _weatherRepository.getWeatherData(cityController.text.trim());

    result.when(
      success: (weatherData) {
        emit(state.loaded(weatherData));
      },
      failure: (error) {
        emit(state.error(error.errMessages));
      },
    );
  }

  // Loads previously cached weather data from local storage
  Future<void> loadCachedWeatherData() async {
    final result = await _weatherRepository.getCachedWeatherData();

    result.when(
      success: (weatherData) {
        emit(state.cached(weatherData));
      },
      failure: (error) {
        emit(state.error(error.errMessages));
      },
    );
  }
}
