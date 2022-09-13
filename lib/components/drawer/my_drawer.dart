import 'package:diet_app/screens/about_us.dart';
import 'package:diet_app/screens/home.dart';
import 'package:diet_app/screens/set_user_data.dart';
import 'package:diet_app/screens/terms_and_privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../designing/designing.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * .7,
        child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                buildProfileHeader(context),
                Container(
                  color: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      buildDrawerListTile(
                        context,
                        "Home",
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.8),
                        ),
                      ),
                      buildDrawerListTile(
                          context,
                          "User Data",
                          Icon(
                            FontAwesomeIcons.receipt,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.8),
                          )),
                      buildDrawerListTile(
                        context,
                        "About Us",
                        FaIcon(
                          Icons.info,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.8),
                        ),
                      ),
                      buildDrawerListTile(
                          context,
                          "Terms and Privacy Policies",
                          Icon(
                            Icons.policy,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.8),
                          ))
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget buildProfileHeader(context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(children: [
          CircleAvatar(
            radius: 80,
            child: Lottie.asset("assets/lotte_animations/diet_plan.json"),
          ),
          SizedBox(height: 20),
          Text("Bingo Diet",
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary))
        ]));
  }

  Widget buildDrawerListTile(context, String title, Widget Icon) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FlatButton(
          onPressed: () {
            title == "Home"
                ? Get.to(Home())
                : title == "User Data"
                    ? Get.to(SetUserData())
                    : title == "About Us"
                        ? Get.to(AboutUs())
                        : Get.to(TermAndPrivacyPolicy());
          },
          child: Row(
            children: [
              Icon,
              SizedBox(width: 10),
              Text(title,
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.8),
                    fontWeight: FontWeight.w500,
                  )),
            ],
          )),
    );
  }
}
