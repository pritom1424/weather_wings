import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_wings/Bloc/weather_bloc.dart';
import 'package:weather_wings/Bloc/weather_event.dart';
import 'package:weather_wings/screens/detail_forecast_screen.dart';
import 'package:weather_wings/screens/footerwidget.dart';
import 'package:weather_wings/screens/home_screen.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Wings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather Wings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.sunny,
              color: Colors.yellow,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontFamily: 'PoetsenOne'),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 300,
                width: 600,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.blue),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            FutureBuilder(
              future: _determinePosition(),
              builder: (ctx, snapshot) => (!snapshot.hasData)
                  ? const Center(child: CircularProgressIndicator())
                  : BlocProvider(
                      create: (ctx) => WeatherBloc()
                        ..add(FetchWeatherEvent(snapshot.data as Position)),
                      child: const HomeScreen(),
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 16, 70, 99),
        tooltip: "Weather forecast details",
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => DetailedForecastScreen(_determinePosition())));
        },
        child: FittedBox(
          fit: BoxFit.contain,
          child: Icon(
            Icons.cloud,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      bottomNavigationBar: FooterWidget(),
    );
  }
}
