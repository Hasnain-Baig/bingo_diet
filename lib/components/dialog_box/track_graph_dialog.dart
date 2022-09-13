import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../button/raised_button.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class TrackGraphDialog extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return AlertDialog(
        content: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Graph",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * .6,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelRotation: 90,
                        title: AxisTitle(
                            text: "Date ${_homeController.graphYear}",
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                        labelStyle: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                            text: "Weight",
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                        labelStyle: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                            markerSettings: MarkerSettings(isVisible: true),
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                            xAxisName: "Date",
                            yAxisName: "Weight",
                            dataSource: _homeController.chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y)
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                MyRaisedButton("Ok")
              ],
            ),
          ),
        ),
      );
    });
  }
}
