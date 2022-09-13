import 'package:animations/animations.dart';
import 'package:diet_app/components/drawer/my_drawer.dart';
import 'package:diet_app/components/others/copy_right_container.dart';
import 'package:diet_app/components/others/diet_table_calendar_container.dart';
import 'package:diet_app/components/others/goal_setting_and_progress_menu_items.dart';
import 'package:diet_app/components/others/meals_snacks_container.dart';
import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/designing/designing.dart';
import '../components/dialog_box/set_goals_dialog.dart';
import '../controllers/date_controller.dart';

class Home extends StatelessWidget {
  @override
  var initYear;
  var initMonth;

  HomeController _homeController = Get.put(HomeController());
  DateController _dateController = Get.put(DateController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (_) {
      return GetBuilder<HomeController>(builder: (_) {
        return SafeArea(
          child: Scaffold(
              drawer: MyDrawer(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  "Diet Bingo",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                centerTitle: true,
              ),
              body: !_homeController.isHomeInitialized
                  ? Center(
                      child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ))
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildDietCalendar(context),
                            buildWeeklyDashboard(context),
                            buildDietTable(context),
                            buildMealTargets(context),
                            buildGoalSettingsAndProgress(context),
                            buildCurrentSetting(context),
                            CopyRightContainer()
                          ],
                        ),
                      ))),
        );
      });
    });
  }

  Widget buildDietCalendar(context) {
    return Container(
        margin: EdgeInsets.only(
          top: 8,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [myBoxShadow(context)],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _dateController.moveToPreviousWeek();
                    print("previous week");
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _dateController.displayWeekDates
                        ? _dateController.hideWeekDates(context)
                        : _dateController.showWeekDates(context);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            child: Image.asset("assets/images/calendar.png")),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Week of ${_dateController.setMonth(_dateController.weekDate.month)} ${_dateController.weekDate.day}, ${_dateController.weekDate.year}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("next week");
                    _dateController.moveToNextWeek();
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
            !_dateController.displayWeekDates
                ? SizedBox(
                    height: 0,
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          padding: EdgeInsets.all(3),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _dateController.weekDatesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            boxShadow: [myBoxShadow(context)],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            )),
                                        child: Text(
                                          "${_dateController.setWeekDay(index)}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${_dateController.weekDatesList[index].day}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
          ],
        ));
  }

  Widget buildWeeklyDashboard(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Weekly Dashboard",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.asset("assets/images/target.png")),
                  SizedBox(
                    width: 3,
                  ),
                  Column(
                    children: [
                      Text(
                        "On Target",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.7),
                        ),
                      ),
                      Text(
                        "${_homeController.sqaureMealCount} of ${(35 - _homeController.numOfPrizeMeals).toInt()}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.7),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      child: Image.asset("assets/images/prize.png")),
                  SizedBox(
                    width: 3,
                  ),
                  Column(
                    children: [
                      Text(
                        "Weekly Prizes",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.7),
                        ),
                      ),
                      Text(
                        "${_homeController.prizeMealCount} of ${_homeController.numOfPrizeMeals.toInt()}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.7),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModal(
                  configuration: FadeScaleTransitionConfiguration(),
                  context: context,
                  builder: (context) {
                    // return MealBudgetDialog();
                    return SetGoalsDialog();
                  });
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(CupertinoIcons.gear_alt),
                  Text(
                    "Set goals",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.7),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDietTable(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FutureBuilder(
          future: _homeController.getDietRecords(),
          builder: (context, snapshot) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, rowIndex) {
                  DateTime incDate =
                      _dateController.weekDate.add(Duration(days: rowIndex));

                  return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 3,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        boxShadow: [myBoxShadow(context)],
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            DietTableCalendarContainer(rowIndex),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MealsSnacksContainer(
                                      rowIndex, incDate, "Meals"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  MealsSnacksContainer(
                                      rowIndex, incDate, "Snacks")
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                });
          }),
    );
  }

  Widget buildMealTargets(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(10),
                child: Text(
                  "Meal Targets",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Goal Meal : ",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.2),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(
                                        "assets/images/target.png"))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _homeController.goalBased == "Intuition" &&
                                    _homeController.hungerLevel == "Mild Hunger"
                                ? "Hunger Level < 1"
                                : _homeController.goalBased == "Intuition" &&
                                        _homeController.hungerLevel ==
                                            "Very Hungry"
                                    ? "Hunger Level < 2"
                                    : _homeController.goalBased ==
                                                "Intuition" &&
                                            _homeController.hungerLevel ==
                                                "Starving"
                                        ? "Hunger Level < 3"
                                        : "${_homeController.goalBased.split(' ')[0]} < ${_homeController.amountPerMeal.toPrecision(1)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(.7),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Prize Meal : ",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.2),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(
                                        "assets/images/prize.png"))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(.7),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGoalSettingsAndProgress(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              child: Text(
                "Goal Settings and Progress",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GoalSettingAndProgressMenuItems('Set Goal'),
                  GoalSettingAndProgressMenuItems('Check Goal'),
                  GoalSettingAndProgressMenuItems('Goal History')
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current Weight : ${_homeController.currentWeight.toPrecision(1)} lbs",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.7),
                    ),
                  ),
                  Text(
                    "Weekly Change : ${_homeController.weeklyChange.toPrecision(1)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.7),
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Widget buildCurrentSetting(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              child: Text(
                "Current Setting",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Goal Type: ${_homeController.goalBased}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(.7),
                  ),
                ),
                _homeController.goalBased == "Intuition"
                    ? Text(
                        "Hunger Level: ${_homeController.hungerLevel}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.7),
                        ),
                      )
                    : Text(
                        "Amount of ${_homeController.goalBased.split(' ')[0]}: ${_homeController.amountPerMeal.toPrecision(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.7),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
