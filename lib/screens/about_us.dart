import 'package:diet_app/components/designing/designing.dart';
import 'package:diet_app/components/others/copy_right_container.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/drawer/my_drawer.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [myBoxShadow(context)],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: Lottie.asset("assets/lotte_animations/about.json"),
              ),
              buildHeader(context, "Bingo Diet"),
              buildPoint(context,
                  "We \"Bingo Diet\" are Providing you the facilities to remain healty and fit using this app."),
              buildPoint(context, "Contact us at: bingo_diet@gmail.com "),
              CopyRightContainer()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(context, title) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [myBoxShadow(context)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget buildPoint(context, point) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(),
      child: Text(
        point,
        style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.7)),
      ),
    );
  }
}
