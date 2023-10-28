import 'dart:math';

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

  String GreetingsAccordingToTime(DateTime dt) {
    double dateNumber = dt.hour + (dt.minute / 60);

    switch (dateNumber) {
      case >= 5 && < (11 + (59 / 60)):
        return "Morning";
      case >= 12 && < (16 + (59 / 60)):
        return "Afternoon";
      case >= 17 || < 4:
        return "Evening";

      default:
        return "Morning";
    }
  }

  void popAdditionalInfo(BuildContext ctx, String windspeed, double windDegree,
      String fTemp, Size scSize) {
    showModalBottomSheet(
        context: ctx,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        builder: (ctx) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.blue, Colors.green])),
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        "Additional Info",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: "PoetsenOne"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                "Wind",
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontFamily: 'Dortmund'),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "-Wind Speed:$windspeed m/s",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "-Wind Direction:$windDegree°",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 76, 216, 209),
                          radius: scSize.height * 0.08,
                          child: Stack(children: [
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                    "assets/weather_images/compass_frame.png")),
                            Transform.rotate(
                              angle: windDegree * pi / 180,
                              origin: Offset(0, 0),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Icon(
                                  Icons.navigation_sharp,
                                  color: Color.fromARGB(255, 223, 232, 223),
                                  size: scSize.height * 0.04,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                          child: Text(
                        "Real Feel:$fTemp °C",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontFamily: "PoetsenOne"),
                      )),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 33, 226, 243)),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ));
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
                              width: 2,
                            ),
                            FittedBox(
                              child: Text(
                                  "${state.weather.areaName!} - ${DateFormat().add_jm().format(state.weather.date!)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            FittedBox(
                              child: Text(
                                "Good ${GreetingsAccordingToTime(state.weather.date!)}!",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    fit: FlexFit.loose,
                    child: ListView(children: [
                      Align(
                        alignment: Alignment.center,
                        child: FadeInImage(
                          height: screenSize.height * 0.25,
                          fit: BoxFit.cover,
                          placeholder: const AssetImage(
                              "assets/weather_images/loading.png"),
                          image: weatherConditionDetector(
                                  state.weather.weatherConditionCode!)
                              .image,
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                popAdditionalInfo(
                                    context,
                                    state.weather.windSpeed.toString(),
                                    state.weather.windDegree!,
                                    state.weather.tempFeelsLike!.celsius!
                                        .round()
                                        .toStringAsFixed(1),
                                    screenSize);
                              },
                              child: Text(
                                'additional info',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )))
                    ]),
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
                              "${state.weather.temperature!.celsius!.toStringAsFixed(1)}°C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Dortmund"),
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
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto'),
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
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto'),
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
