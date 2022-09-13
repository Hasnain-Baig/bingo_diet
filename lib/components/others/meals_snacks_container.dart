import 'package:diet_app/components/others/diet_table_circle_avatar.dart';
import 'package:diet_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../designing/designing.dart';

class MealsSnacksContainer extends StatelessWidget {
  int rowIndex;
  DateTime incDate;
  String title;

  MealsSnacksContainer(this.rowIndex, this.incDate, this.title);
  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return rowIndex == 0
          ? Container(
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).colorScheme.onPrimary,
                        boxShadow: [myBoxShadow(context)],
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: title == "Snacks" ? 2 : 3,
                          itemBuilder: (BuildContext context, int index) {
                            return title == "Snacks"
                                ? DietTableCircleAvatar(
                                    'Snacks', 10, 14, rowIndex, index, incDate)
                                : DietTableCircleAvatar(
                                    'Meals', 12, 16, rowIndex, index, incDate);
                          }))
                ],
              ),
            )
          : Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).colorScheme.onPrimary,
                boxShadow: [myBoxShadow(context)],
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: title == "Snacks" ? 2 : 3,
                  itemBuilder: (BuildContext context, int index) {
                    return title == "Snacks"
                        ? DietTableCircleAvatar(
                            'Snacks', 10, 14, rowIndex, index, incDate)
                        : DietTableCircleAvatar(
                            'Meals', 12, 16, rowIndex, index, incDate);
                  }));
    });
  }
}
