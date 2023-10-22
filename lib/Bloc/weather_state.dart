import 'package:weather/weather.dart';

abstract class WeatherState {}

class WeatherInitState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  final Weather weather;
  WeatherSuccessState(this.weather);
}

class WeatherFailureState extends WeatherState {}
