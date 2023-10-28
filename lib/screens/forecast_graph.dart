import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/weather.dart';

class ForecastGraph extends StatelessWidget {
  final List<Weather> weatherList;
  const ForecastGraph(this.weatherList, {super.key});

  List<ChartData> getChartData(List<Weather> wtList) {
    List<ChartData> cData = [];
    for (int i = 0; i < wtList.length; i++) {
      cData.add(ChartData("${DateFormat().add_jm().format(wtList[i].date!)}",
          wtList[i].temperature!.celsius!.round().toDouble()));
    }
    return cData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            "Weather Condition-${weatherList[0].weatherMain!.toLowerCase()}",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 35, 220, 248),
                fontFamily: "PoetsenOne"),
          ),
        ),
        Container(
          width: double.infinity,
          height: 180,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: 'time (12 hr)',
                    textStyle: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.normal,
                        fontFamily: "PoetsenOne")),
                labelStyle: TextStyle(color: Colors.white)),
            primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: 'temp (°C)',
                    textStyle: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.normal,
                        fontFamily: "PoetsenOne")),
                labelStyle: TextStyle(color: Colors.white)),
            series: <ChartSeries>[
              SplineSeries<ChartData, String>(
                  color: Colors.white,
                  dataSource: getChartData(weatherList),
                  cardinalSplineTension: 0.9,
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.temparature,
                  markerSettings: MarkerSettings(isVisible: true),
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal)))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: FittedBox(
            alignment: Alignment.center,
            child: Text(
              "Date: ${DateFormat("dd-MM-yyyy").format(weatherList[0].date!)}",
              style: TextStyle(
                  color: Color.fromARGB(255, 32, 238, 183),
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoetsenOne"),
            ),
          ),
        )
      ],
    );
  }
}

class ChartData {
  final String time;
  final double temparature;

  ChartData(this.time, this.temparature);
}
