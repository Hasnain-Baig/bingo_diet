import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'track_graph_dialog.dart';
import 'track_progress_dialog.dart';
import 'track_spot_light_dialog.dart';

class TrackProgressMenuItemsDialog extends StatelessWidget {
  TrackProgressMenuItemsDialog();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildTrackProgressMenuItem(context, 'Set Goal'),
                    buildTrackProgressMenuItem(context, 'Check Goal'),
                    buildTrackProgressMenuItem(context, 'Goal History'),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildTrackProgressMenuItem(context, val) {
    return InkWell(
        onTap: () {
          Get.back();
          val == "Set Goal"
              ? showDialog(
                  context: context,
                  builder: (builder) {
                    return TrackProgressDialog();
                  })
              : val == "Goal History"
                  ? showDialog(
                      context: context,
                      builder: (builder) {
                        return TrackGraphDialog();
                      })
                  : val == "Check Goal"
                      ? showDialog(
                          context: context,
                          builder: (builder) {
                            return TrackSpotLightDialog();
                          })
                      : () {};
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  child: val == "Set Goal"
                      ? Image.asset("assets/images/target.png")
                      : val == "Goal History"
                          ? Image.asset("assets/images/graph.png")
                          : val == "Check Goal"
                              ? Image.asset("assets/images/trafficlight.png")
                              : Text("")),
              SizedBox(
                height: 5,
              ),
              Text(
                val,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ));
  }
}
