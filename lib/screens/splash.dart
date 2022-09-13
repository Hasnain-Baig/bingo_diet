import 'package:diet_app/components/designing/designing.dart';
import 'package:diet_app/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          gradient: myLinearGradient(context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .4,
              child: Image.asset(
                "assets/images/bingo_logo_circular.png",
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      "Bingo Diet",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 34),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Win Your Goals",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 14),
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
