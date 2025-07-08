import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/core/export.dart';
import 'package:weather_app/features/home/export.dart';

class WeatherSkeletonLoader extends StatelessWidget {
  const WeatherSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Card(
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
                  'Weather App loading',
                  style: AppStyle.font14_400Weight.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(5),
                Text(
                  'Weather App loading',
                  style: AppStyle.font14_700Weight.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
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
                      horizontalSpace(16),
                      Column(
                        children: [
                          Text(
                            'Weather App loading',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          Text(
                            'Weather App loading',
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
                      const WeatherDetailsRow(
                        icon: Icons.air,
                        label: 'Wind Direction',
                        value: 'Weather App loading',
                      ),
                      Divider(height: 20.h, color: Colors.grey.shade200),
                      const WeatherDetailsRow(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: 'Weather App loading',
                      ),
                      Divider(height: 20.h, color: Colors.grey.shade200),
                      const WeatherDetailsRow(
                        icon: Icons.wb_sunny,
                        label: 'UV Index',
                        value: 'Weather App loading',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
