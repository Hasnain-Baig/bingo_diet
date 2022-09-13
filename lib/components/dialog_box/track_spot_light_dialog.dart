import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../button/raised_button.dart';

class TrackSpotLightDialog extends StatelessWidget {
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
                  "Spotlight",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                _homeController.spotlightColor == "red"
                    ? Container(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Lottie.asset(
                                  "assets/lotte_animations/light-red.json"),
                            ),
                            Column(
                              children: [
                                Text(
                                  "😔",
                                  style: TextStyle(
                                    fontSize: 48,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  // "You are Under Diet!",
                                  "You are gaining weight!",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : _homeController.spotlightColor == "yellow"
                        ? Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Lottie.asset(
                                      "assets/lotte_animations/light-yellow.json"),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "☺️",
                                      style: TextStyle(
                                        fontSize: 48,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      // "You are going with Diet!",
                                      "You have same weight!",

                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : _homeController.spotlightColor == "green"
                            ? Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Lottie.asset(
                                          "assets/lotte_animations/light-green.json"),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "😇",
                                          style: TextStyle(
                                            fontSize: 48,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          // "You are having healthy Diet!",
                                          "You are loosing weight!",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(height: 0),
                SizedBox(
                  height: 10,
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
