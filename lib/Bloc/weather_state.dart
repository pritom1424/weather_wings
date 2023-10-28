import 'package:weather/weather.dart';

abstract class WeatherState {}

class WeatherInitState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  final Weather weather;
  WeatherSuccessState(this.weather);
}

class WeatherForecastSuccessState extends WeatherState {
  final List<Weather> weathers;
  WeatherForecastSuccessState(this.weathers);
}

class WeatherFailureState extends WeatherState {}
