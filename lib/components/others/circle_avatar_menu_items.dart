import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAvatarMenuItems extends StatelessWidget {
  String value;
  String val;
  DateTime date;
  int rowIndex;
  Map tmpTrue;
  Map tmpFalse;

  CircleAvatarMenuItems(this.value, this.val, this.date, this.rowIndex,
      this.tmpTrue, this.tmpFalse);
  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return InkWell(
        onTap: () {
          Get.back();
          val == "Goal"
              ? _homeController.takeAsGoalMeal(
                  value, date, rowIndex, tmpTrue, tmpFalse)
              : val == "Prize"
                  ? _homeController.takeAsPrizeMeal(
                      context, value, date, rowIndex, tmpTrue["index"])
                  : val == "Skip"
                      ? _homeController.takeAsSkip(
                          value, date, rowIndex, tmpTrue, tmpFalse)
                      : () {};
        },
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 40,
                height: 40,
                child: val == "Goal"
                    ? Image.asset("assets/images/target.png")
                    : val == "Prize"
                        ? Image.asset("assets/images/prize.png")
                        : val == "Skip"
                            ? Image.asset("assets/images/skip.png")
                            : Text("")),
            SizedBox(
              height: 5,
            ),
            Text(
              val,
              style: TextStyle(fontSize: 14),
            )
          ],
        )),
      );
    });
  }
}
