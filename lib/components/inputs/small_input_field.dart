import 'package:diet_app/controllers/animation_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallInputField extends StatelessWidget {
  String val;
  TextEditingController controller;
  SmallInputField(this.val, this.controller);

  MyAnimationController _animationController = Get.put(MyAnimationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAnimationController>(builder: (_) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              val,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 2),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).colorScheme.onSecondary,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          border: InputBorder.none,
                          hintText: val,
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        onChanged: (val) {
                          _animationController.updateState();
                        }),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  val == "Body Fat %"
                      ? _animationController.validateBodyFat(controller.text) ==
                              null
                          ? Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Colors.transparent,
                              size: 24,
                            )
                          : _animationController
                                  .validateBodyFat(controller.text)
                              ? Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: Colors.green,
                                  size: 24,
                                )
                              : Icon(
                                  CupertinoIcons.xmark_circle_fill,
                                  color: Colors.red,
                                  size: 24,
                                )
                      : _animationController
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
                                ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
