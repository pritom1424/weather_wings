import 'package:geolocator/geolocator.dart';

abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final Position pos;

  FetchWeatherEvent(this.pos);
}

class FetchForecastEvent extends WeatherEvent {
  final Position pos;
  FetchForecastEvent(this.pos);
}
