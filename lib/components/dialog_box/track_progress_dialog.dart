import 'package:diet_app/components/others/loading_container.dart';
import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../button/raised_button.dart';
import '../inputs/small_input_field.dart';

HomeController _homeController = Get.put(HomeController());

class TrackProgressDialog extends StatelessWidget {
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
                  "Track Progress",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallInputField("Weight", _homeController.weightController),
                    Text(
                      "Last ${_homeController.currentWeight.toPrecision(1)}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallInputField(
                        "Body Fat %", _homeController.bodyFatController),
                    Text(
                      "Last ${_homeController.bodyFat.toPrecision(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Satisfaction",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SfLinearGauge(
                  showTicks: false,
                  interval: 1,
                  axisTrackStyle: LinearAxisTrackStyle(
                      thickness: 10,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      color: Theme.of(context).colorScheme.primary),
                  axisLabelStyle: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary),
                  minimum: 1,
                  maximum: 10,
                  markerPointers: [
                    LinearWidgetPointer(
                      animationType: LinearAnimationType.bounceOut,
                      value: _homeController.satisfactionLevel,
                      dragBehavior: LinearMarkerDragBehavior.free,
                      onChanged: (double newValue) {
                        _homeController.setSatisfactionLevel(newValue);
                        print(_homeController.satisfactionLevel);
                      },
                      position: LinearElementPosition.cross,
                      child: Text(
                        "😁",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ],
                ), // Text(
                SizedBox(
                  height: 20,
                ),

                _homeController.isLoading
                    ? LoadingContainer()
                    : MyRaisedButton("Set Record")
              ],
            ),
          ),
        ),
      );
    });
    // });
  }
}
