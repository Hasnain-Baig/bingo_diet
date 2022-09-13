import 'package:flutter/material.dart';

class CopyRightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Opacity(
          opacity: 0.7,
          child: Text(
            "Diet Bingo \u00A92022",
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
