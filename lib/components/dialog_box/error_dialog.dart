import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../button/raised_button.dart';

class MyErrorDialog extends StatelessWidget {
  String title;
  MyErrorDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Lottie.asset("assets/lotte_animations/ex_error.json"),
              ),
              Container(
                transformAlignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .5,
                alignment: Alignment.center,
                child:
                    Center(child: Text(title, style: TextStyle(fontSize: 14))),
              ),
              SizedBox(height: 20),
              MyRaisedButton("Ok")
            ],
          ),
        ),
      ),
    );
  }
}
