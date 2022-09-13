import 'package:diet_app/components/designing/designing.dart';
import 'package:diet_app/components/inputs/std_input_field.dart';
import 'package:diet_app/components/others/loading_container.dart';
import 'package:diet_app/controllers/set_user_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/button/raised_button.dart';
import '../components/drawer/my_drawer.dart';
import '../controllers/animation_controller.dart';

class SetUserData extends StatelessWidget {
  MyAnimationController _animationController = Get.put(MyAnimationController());
  SetUserDataController _setUserDataController =
      Get.put(SetUserDataController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetUserDataController>(builder: (_) {
      return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              "User Data",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            centerTitle: true,
            actions: [],
          ),
          body: !_setUserDataController.isUserInitialized
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))
              : GetBuilder<MyAnimationController>(
                  builder: (_) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: double.infinity,
                      decoration:
                          BoxDecoration(gradient: myLinearGradient(context)),
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            AnimatedOpacity(
                                opacity: _animationController.opacity,
                                duration: Duration(milliseconds: 500),
                                child: buildFormContainer(context)),
                          ],
                        ),
                      ),
                    );
                  },
                ));
    });
  }

  Widget buildFormContainer(context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * .8,
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.all(_animationController.margin),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: !_setUserDataController.editUser
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text("User Info", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 30),
                  buildInfoTile(
                      context,
                      "Gender",
                      _setUserDataController.gender,
                      CupertinoIcons.person_2_fill),
                  SizedBox(height: 20),
                  buildInfoTile(
                      context,
                      "Age",
                      "${_setUserDataController.age.toPrecision(1)} years",
                      Icons.calendar_month),
                  SizedBox(height: 20),
                  buildInfoTile(
                      context,
                      "Height",
                      "${_setUserDataController.height.toPrecision(1)} cm",
                      CupertinoIcons.arrow_up_arrow_down),
                  SizedBox(height: 10),
                  MyRaisedButton("Edit Info"),
                  SizedBox(height: 40),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text("Add Info", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 30),
                  buildGenderFieldContainer(context, "Gender"),
                  SizedBox(height: 20),
                  StdInputField(
                      "Age (year)", _setUserDataController.ageController),
                  SizedBox(height: 20),
                  StdInputField(
                      "Height (cm)", _setUserDataController.heightController),
                  SizedBox(height: 10),
                  _setUserDataController.isLoading
                      ? LoadingContainer()
                      : MyRaisedButton("Update"),
                  SizedBox(height: 40),
                ],
              ),
      ),
    );
  }

  Widget buildInfoTile(context, String key, String value, icon) {
    return Container(
        width: MediaQuery.of(context).size.width * .6,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.6),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(key,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(.6),
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: Theme.of(context).colorScheme.primary,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(value,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.5),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ],
        ));
  }

  Widget buildGenderFieldContainer(context, title) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        width: MediaQuery.of(context).size.width * .6,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.person_2_fill,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.6),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${title}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.6),
                      )),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCheckBoxContainer(
                          "Male", _setUserDataController.isMale, setState),
                      buildCheckBoxContainer(
                          "Female", !_setUserDataController.isMale, setState),
                    ]))
          ],
        ),
      );
    });
  }

  Widget buildCheckBoxContainer(title, value, setState) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          Checkbox(
            value: value,
            onChanged: (val) {
              _setUserDataController.setGender();
            },
          ), //Checkbox
          //Text
        ], //<Widget>[]
      ),
    );
  }
}
