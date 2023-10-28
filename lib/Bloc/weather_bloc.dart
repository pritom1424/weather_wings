import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_wings/Bloc/weather_event.dart';
import 'package:weather_wings/Bloc/weather_state.dart';
import 'package:weather/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final String apikey = "cd4c567c6d06a6857ee6ac82af774c44";
  WeatherBloc() : super(WeatherInitState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        WeatherFactory wf = WeatherFactory(apikey, language: Language.ENGLISH);
        Weather currWeather = await wf.currentWeatherByLocation(
            event.pos.latitude, event.pos.longitude);

        print(currWeather);
        emit(WeatherSuccessState(currWeather));
      } catch (e) {
        emit(WeatherFailureState());
      }
    });

    on<FetchForecastEvent>(
      (event, emit) async {
        emit(WeatherLoadingState());
        try {
          WeatherFactory wf =
              WeatherFactory(apikey, language: Language.ENGLISH);
          List<Weather> weathers = await wf.fiveDayForecastByLocation(
              event.pos.latitude, event.pos.longitude);

          emit(WeatherForecastSuccessState(weathers));
        } catch (e) {
          emit(WeatherFailureState());
        }
      },
    );
  }
}
