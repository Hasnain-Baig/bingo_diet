import 'package:animations/animations.dart';
import 'package:diet_app/controllers/date_controller.dart';
import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dialog_box/circle_avatar_menu_dialog.dart';

class DietTableCircleAvatar extends StatelessWidget {
  DateTime date;
  int index;
  int rowIndex;
  String value;
  double fontSize;
  double radius;
  DietTableCircleAvatar(
    this.value,
    this.fontSize,
    this.radius,
    this.rowIndex,
    this.index,
    this.date,
  );
  DateController _dateController = Get.put(DateController());
  HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (_) {
      return GetBuilder<HomeController>(builder: (_) {
        return InkWell(
          onTap: () {
            Map tmpTrue = {"index": index, "value": true};
            Map tmpFalse = {"index": index, "value": false};

            if (_homeController.isDateExists(date.toString().split(' ')[0]) &&
                _dateController.compareStringDate(
                    _dateController.setWeekDate(_dateController.nowDate),
                    date)) {
              _homeController.isMealSelected(
                      value, date, rowIndex, tmpTrue, tmpFalse)
                  ? _homeController.unSelectMeal(
                      value, date, rowIndex, tmpTrue, tmpFalse)
                  : showModal(
                      configuration: FadeScaleTransitionConfiguration(),
                      context: context,
                      builder: (context) {
                        return CircleAvatarMenuDialog(
                            value, date, rowIndex, tmpTrue, tmpFalse);
                      });
            }
          },
          child: Container(
            margin: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: radius,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.2),
              child: CircleAvatar(
                  backgroundColor: !_dateController.compareStringDate(
                          _dateController.setWeekDate(_dateController.nowDate),
                          date)
                      ? Colors.grey.withOpacity(.2)
                      : !_homeController.isDateExists(
                                  date.toString().split(' ')[0]) &&
                              !_dateController.compareStringDate(
                                  _dateController.nowDate, date)
                          ? Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.1)
                          : Colors.white,
                  radius: (radius - 1),
                  child: !_homeController.isDateExists(date)
                      ? Text(
                          "",
                          style: TextStyle(
                              fontSize: fontSize,
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      : _homeController.isCircleLoading &&
                              _homeController.circleLoadingIndex == index &&
                              _homeController.circleLoadingRowIndex ==
                                  rowIndex &&
                              _homeController.circleLoadingValue == value
                          ? Container(
                              width: radius + 2,
                              height: radius + 2,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.5),
                              ))
                          : _homeController.checkIndexInPrizeList(index, value)
                              ? Container(
                                  width: radius + 4,
                                  height: radius + 4,
                                  child: Image.asset("assets/images/prize.png"))
                              : !_homeController.checkIndexInFoodsList(
                                      index, value)
                                  ? Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    )
                                  : _homeController.checkObjInFoodsList(
                                          index, value)
                                      ? Container(
                                          width: radius + 4,
                                          height: radius + 4,
                                          child: Image.asset(
                                              "assets/images/target.png"))
                                      : Container(
                                          width: radius + 4,
                                          height: radius + 4,
                                          child: Image.asset(
                                              "assets/images/skip.png"))),
            ),
          ),
        );
      });
    });
  }
}
