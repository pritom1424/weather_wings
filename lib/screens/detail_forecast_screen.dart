import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_wings/Bloc/weather_bloc.dart';
import 'package:weather_wings/Bloc/weather_event.dart';
import 'package:weather_wings/Bloc/weather_state.dart';
import 'package:weather_wings/screens/forecast_graph.dart';

class DetailedForecastScreen extends StatelessWidget {
  final Future<Position> dtPosition;
  const DetailedForecastScreen(this.dtPosition, {super.key});

  List<Weather> getWeathersbyDate(
      List<Weather> totalWeather, int daysFromTomorrow) {
    List<Weather> weathers = [];
    DateFormat format = DateFormat.yMd();

    for (int i = 0; i < totalWeather.length; i++) {
      if (format.format(totalWeather[i].date!).compareTo(format.format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day + 1 + daysFromTomorrow))) ==
          0) {
        weathers.add(totalWeather[i]);
      }
    }

    return weathers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dtPosition,
        builder: (ctx, snapshot) {
          return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                foregroundColor: Colors.white,
                title: Text(
                  "Next Three Days Forecast",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontFamily: "PoetsenOne"),
                ),
                backgroundColor: Colors.transparent,
              ),
              body: (!snapshot.hasData)
                  ? const Center(child: CircularProgressIndicator())
                  : BlocProvider<WeatherBloc>(
                      create: (ctx) => WeatherBloc()
                        ..add(FetchForecastEvent(snapshot.data as Position)),
                      child: BlocBuilder<WeatherBloc, WeatherState>(
                        builder: (ctx, state) => (state
                                is WeatherForecastSuccessState)
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                child: Stack(children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 300,
                                      width: 600,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.red),
                                    ),
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 100, sigmaY: 100),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                    ),
                                  ),
                                  Container(
                                    child: ListView(
                                      children: [
                                        ForecastGraph(
                                          getWeathersbyDate(state.weathers, 0),
                                        ),
                                        ForecastGraph(
                                          getWeathersbyDate(state.weathers, 1),
                                        ),
                                        ForecastGraph(getWeathersbyDate(
                                            state.weathers, 2))
                                      ],
                                    ),
                                  ),
                                ]),
                              )
                            : (state is WeatherFailureState)
                                ? const Center(
                                    child: Text(
                                        "something went wrong! check connection! try again!"),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                      ),
                    ));
        });
  }
}
