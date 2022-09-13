import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropdownInput extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());

  List goalBasedArr = [
    "Calories per meal",
    "Intuition",
    "Protiens (g) per meal",
    "Carbs (g) per meal",
    "Fats (g) per meal"
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Container(
        width: MediaQuery.of(context).size.width * .7,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 45,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          value: _homeController.goalBased,
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          items: goalBasedArr.map((items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            _homeController.setGoalBased(newValue);
          },
        ),
      );
    });
  }
}
