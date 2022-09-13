import 'package:diet_app/components/inputs/dropdown_input.dart';
import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../button/raised_button.dart';
import '../inputs/std_input_field.dart';
import '../others/loading_container.dart';
import 'error_dialog.dart';

class SetGoalsDialog extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());
  List hungerLevelList = ["Mild Hunger", "Very Hungry", "Starving"];

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.gear_alt),
                    Text(
                      "Set Goals",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Set Meal Target",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                        width: 18,
                        height: 18,
                        child: Image.asset("assets/images/target.png"))
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                MyDropdownInput(),
                SizedBox(
                  height: 15,
                ),
                _homeController.tmpGoal == "Intuition"
                    ? Column(
                        children: [
                          Text(
                            "Select hunger level",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 1,
                            height: 50,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _homeController.setHungerLevel(
                                                hungerLevelList[index]);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                child: Text("${index + 1}"),
                                                backgroundColor: _homeController
                                                            .hungerLevel ==
                                                        hungerLevelList[index]
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(.5),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                hungerLevelList[index],
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  try {
                                    launch("https://tdeecalculator.net/");
                                  } catch (e) {
                                    MyErrorDialog("Error: $e");
                                  }
                                },
                                child: Text(
                                  "https://tdeecalculator.net/",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 51, 48, 219)),
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.calculator,
                                size: 16,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StdInputField(
                              "Enter Amount of ${_homeController.tmpGoal.split(' ')[0]}",
                              _homeController.amountPerMealController),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Set Prizes",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                        width: 18,
                        height: 18,
                        child: Image.asset("assets/images/prize.png"))
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _homeController
                                      .setNumOfPrizeMeals("${index + 1}");
                                },
                                child: CircleAvatar(
                                  radius: 16,
                                  child: Text("${index + 1}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary)),
                                  backgroundColor: _homeController
                                              .numOfPrizeMeals ==
                                          index + 1
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                _homeController.isLoading
                    ? LoadingContainer()
                    : MyRaisedButton("Set")
              ],
            ),
          ),
        ),
      );
    });
  }
}
