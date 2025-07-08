import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/export.dart';
import 'package:weather_app/features/home/export.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherModel weather;
  final bool isOffline;

  const WeatherInfoWidget({
    super.key,
    required this.weather,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    final iconUrl = 'https:${weather.current.condition.icon}';

    return Card(
      elevation: 8,
      shadowColor: AppColor.primaryColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${weather.location.name}, ${weather.location.country}',
                style: AppStyle.font14_400Weight.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(5),
              Text(
                weather.location.localtime,
                style: AppStyle.font14_700Weight.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 14.sp,
                ),
              ),
              if (isOffline)
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.shade800),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.offline_bolt,
                          size: 16.sp,
                          color: Colors.amber.shade800,
                        ),
                        horizontalSpace(4),
                        Text(
                          'Offline data',
                          style: AppStyle.font11_400Weight.copyWith(
                            color: Colors.amber.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              verticalSpace(25),
              Container(
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isOffline
                        ? Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.cloud,
                              size: 50.sp,
                              color: Colors.grey,
                            ),
                          )
                        : SizedBox(
                            width: 80.w,
                            height: 80.h,
                            child: CustomNetworkImage(
                              imageUrl: iconUrl,
                              placeholderWidget: Skeletonizer(
                                child: Container(
                                  width: 80.w,
                                  height: 80.h,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                          ),
                    horizontalSpace(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.current.tempC.round()}°C',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        Text(
                          weather.current.condition.text,
                          style: AppStyle.font11_400Weight.copyWith(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(25),
              Container(
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    WeatherDetailsRow(
                      icon: Icons.air,
                      label: 'Wind Direction',
                      value: weather.current.windDir,
                    ),
                    Divider(height: 20.h, color: Colors.grey.shade200),
                    WeatherDetailsRow(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '${weather.current.humidity}%',
                    ),
                    Divider(height: 20.h, color: Colors.grey.shade200),
                    WeatherDetailsRow(
                      icon: Icons.wb_sunny,
                      label: 'UV Index',
                      value: '${weather.current.uv}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
