import 'package:diet_app/controllers/date_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../designing/designing.dart';

DateController _dateController = Get.put(DateController());

class DietTableCalendarContainer extends StatelessWidget {
  int index;
  DietTableCalendarContainer(this.index);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (_) {
      return Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            gradient: myLinearGradient(context),
            boxShadow: [myBoxShadow(context)],
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _dateController.setWeekDay(index),
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              Container(
                  width: 18,
                  height: 18,
                  child: Image.asset("assets/images/calendar.png")),
            ],
          ),
        ),
      );
    });
  }
}
