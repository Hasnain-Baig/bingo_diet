import 'package:diet_app/controllers/animation_controller.dart';
import 'package:diet_app/controllers/set_user_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StdInputField extends StatelessWidget {
  String value;
  TextEditingController controller;
  StdInputField(this.value, this.controller);
  MyAnimationController _animationController = Get.put(MyAnimationController());
  SetUserDataController _setUserDataController =
      Get.put(SetUserDataController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAnimationController>(builder: (_) {
      return GetBuilder<SetUserDataController>(builder: (_) {
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .6,
              height: 45,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: (value == "Weight (kg)" ||
                      value == "Age (year)" ||
                      value == "Height (cm)")
                  ? TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).colorScheme.onSecondary,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          hintText: value,
                          hintStyle: TextStyle(fontSize: 14),
                          prefixIcon: value == "Age (year)"
                              ? Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.6),
                                )
                              : value == "Height (cm)"
                                  ? Icon(
                                      CupertinoIcons.arrow_up_arrow_down,
                                      size: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(0.6),
                                    )
                                  : value == "Weight (kg)"
                                      ? Icon(
                                          Icons.workspaces,
                                          size: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(0.6),
                                        )
                                      : Text(""),
                          suffixIcon: _animationController
                                      .validateTextField(controller.text) ==
                                  null
                              ? Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: Colors.transparent,
                                  size: 24,
                                )
                              : _animationController
                                      .validateTextField(controller.text)
                                  ? Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                      size: 24,
                                    )
                                  : Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.red,
                                      size: 24,
                                    )),
                      onChanged: (val) {
                        _animationController.updateState();
                      },
                    )
                  : TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).colorScheme.onSecondary,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          hintText: value,
                          hintStyle: TextStyle(fontSize: 14),
                          suffixIcon: _animationController
                                      .validateTextField(controller.text) ==
                                  null
                              ? Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: Colors.transparent,
                                  size: 24,
                                )
                              : _animationController
                                      .validateTextField(controller.text)
                                  ? Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                      size: 24,
                                    )
                                  : Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.red,
                                      size: 24,
                                    )),
                      onChanged: (val) {
                        _animationController.updateState();
                      },
                    ),
            ),
          ],
        );
      });
    });
  }
}
