import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

void registerWeatherAdapters() {
  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(CurrentAdapter());
  Hive.registerAdapter(ConditionAdapter());
}

@HiveType(typeId: 0)
@JsonSerializable()
class WeatherModel {
  @HiveField(0)
  final Location location;
  @HiveField(1)
  final Current current;

  WeatherModel({
    required this.location,
    required this.current,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@HiveType(typeId: 1)
@JsonSerializable()
class Location {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String region;
  @HiveField(2)
  final String country;
  @HiveField(3)
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Current {
  @HiveField(0)
  @JsonKey(name: 'temp_c')
  final double tempC;
  @HiveField(1)
  final Condition condition;
  @HiveField(2)
  @JsonKey(name: 'wind_dir')
  final String windDir;
  @HiveField(3)
  final int humidity;
  @HiveField(4)
  final double uv;

  Current({
    required this.tempC,
    required this.windDir,
    required this.condition,
    required this.humidity,
    required this.uv,
  });

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}

@HiveType(typeId: 3)
@JsonSerializable()
class Condition {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final String icon;
  @HiveField(2)
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}
