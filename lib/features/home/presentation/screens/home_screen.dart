import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/export.dart';
import 'package:weather_app/features/home/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _cityController;
  late GlobalKey<FormState> _formKey;
  late WeatherCubit _weatherCubit;
  late InternetCubit _internetCubit;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _weatherCubit = context.read<WeatherCubit>();
    _internetCubit = context.read<InternetCubit>();
    _cityController = _weatherCubit.cityController;
    _formKey = _weatherCubit.formKey;
    _internetCubit.checkConnectivity();
    _weatherCubit.loadCachedWeatherData();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  // Show snackbar for internet connection
  void _showNoInternetMessage({required bool isOffline}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isOffline
            ? 'Internet is not connected, you can not search for new data'
            : 'Internet now is connected'),
        backgroundColor: isOffline ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      ),
    );
  }

  // Search for weather data
  void _searchWeather() {
    if (_formKey.currentState!.validate()) {
      if (_isConnected) {
        _weatherCubit.getWeatherData();
        FocusScope.of(context).unfocus();
      } else {
        _showNoInternetMessage(isOffline: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: AppStyle.font18_600Weight.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor.withOpacity(0.8),
              AppColor.primaryColor.withOpacity(0.5),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              children: [
                verticalSpace(16),
                // Search form widget
                SearchFormWidget(
                  formKey: _formKey,
                  cityController: _cityController,
                  isConnected: _isConnected,
                  onSearch: _searchWeather,
                  showNoInternetMessage: _showNoInternetMessage,
                ),
                verticalSpace(20),
                // Weather info widget
                Expanded(
                  child: BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      if (state.status == WeatherStatus.loading) {
                        return const WeatherSkeletonLoader();
                      } else if (state.status == WeatherStatus.loaded ||
                          state.status == WeatherStatus.cached) {
                        return WeatherInfoWidget(
                          weather: state.weatherData!,
                          isOffline: state.status == WeatherStatus.cached,
                        );
                      } else if (state.status == WeatherStatus.error) {
                        return ErrorMessageWidget(
                            errorMessage: state.errorMessage!);
                      } else {
                        return const EmptyStateWidget();
                      }
                    },
                  ),
                ),
                BlocListener<InternetCubit, InternetState>(
                  listener: (context, state) {
                    if (state is ConnectedState) {
                      setState(() {
                        _isConnected = true;
                      });
                    } else if (state is NotConnectedState) {
                      setState(() {
                        _isConnected = false;
                      });
                      _showNoInternetMessage(isOffline: true);
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
