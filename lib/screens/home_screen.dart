import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_wings/Bloc/weather_bloc.dart';
import 'package:weather_wings/Bloc/weather_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Image weatherConditionDetector(int wcCode) {
    switch (wcCode) {
      case >= 200 && < 300:
        return Image.asset(
          "assets/weather_images/Thunderstorm.png",
        );
      case >= 300 && < 400:
        return Image.asset(
          "assets/weather_images/drizzle.png",
        );
      case >= 500 && < 600:
        return Image.asset("assets/weather_images/rain.png");
      case >= 600 && < 700:
        return Image.asset("assets/weather_images/snow.png");
      case > 700 && < 800:
        return Image.asset(
          "assets/weather_images/sun-and-wind.png",
        );
      case > 800 && < 805:
        return Image.asset("assets/weather_images/clouds.png");
      default:
        return Image.asset(
          "assets/weather_images/sun.png",
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return (state is WeatherSuccessState)
          ? SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                children: [
                  //first part
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place_rounded,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            FittedBox(
                              child: Text(state.weather.areaName!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            FittedBox(
                              child: const Text(
                                "Good Morning!",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: FadeInImage(
                        placeholder: const AssetImage(
                            "assets/weather_images/loading.png"),
                        image: weatherConditionDetector(
                                state.weather.weatherConditionCode!)
                            .image,
                      ),
                    ),
                  ),
                  //second part
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: FittedBox(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round().toStringAsFixed(1)}°C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Center(
                          child: FittedBox(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Center(
                          child: FittedBox(
                            child: Text(
                              DateFormat.yMMMd().format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  //3rd part
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/weather_images/sun200.png",
                                  scale: 4,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: const Text(
                                        "Sunrise",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/weather_images/moon200.png",
                                  scale: 6,
                                  alignment: Alignment.center,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: const Text(
                                        "Sunset",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01),
                          child: Divider(
                            color: Color.fromARGB(255, 79, 76, 76),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/weather_images/tempMax256.png",
                                  scale: 6,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: const Text(
                                        "Temp Max",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "${state.weather.tempMax!.celsius!.toStringAsFixed(1)}°C",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/weather_images/tempMin256.png",
                                  scale: 6,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: const Text(
                                        "Temp Min",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "${state.weather.tempMin!.celsius!.toStringAsFixed(1)}°C",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))
          : (state is WeatherFailureState)
              ? const Center(
                  child: Text(
                      "something went wrong! check connection! try again!"),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
    });
  }
}
