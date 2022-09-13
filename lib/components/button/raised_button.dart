import 'package:diet_app/controllers/home_controller.dart';
import 'package:diet_app/controllers/set_user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRaisedButton extends StatelessWidget {
  String val;
  MyRaisedButton(this.val);

  HomeController _homeController = Get.put(HomeController());
  SetUserDataController _setUserData = Get.put(SetUserDataController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetUserDataController>(builder: (_) {
      return GetBuilder<HomeController>(builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width * .5,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.primary,
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.6),
              onPressed: () {
                if (val == "Set") {
                  _homeController.setGoal(context);
                } else if (val == "Set Record") {
                  _homeController.setRecord(context);
                } else if (val == "Update") {
                  _setUserData.setData(context);
                } else if (val == "Edit Info") {
                  _setUserData.editUserData();
                } else if (val == "Ok") {
                  Get.back();
                }
              },
              child: Text(val)),
        );
      });
    });
  }
}
