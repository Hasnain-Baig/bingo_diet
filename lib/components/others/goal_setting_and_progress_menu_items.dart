import 'package:flutter/material.dart';
import '../dialog_box/track_graph_dialog.dart';
import '../dialog_box/track_progress_dialog.dart';
import '../dialog_box/track_spot_light_dialog.dart';

class GoalSettingAndProgressMenuItems extends StatelessWidget {
  String val;
  GoalSettingAndProgressMenuItems(this.val);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                  width: 30,
                  height: 30,
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
