import 'package:diet_app/components/others/circle_avatar_menu_items.dart';
import 'package:flutter/material.dart';

class CircleAvatarMenuDialog extends StatelessWidget {
  DateTime date;
  int rowIndex;
  Map tmpTrue;
  Map tmpFalse;
  String value;
  CircleAvatarMenuDialog(
      this.value, this.date, this.rowIndex, this.tmpTrue, this.tmpFalse);

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
              value == "Snacks"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatarMenuItems(
                          value,
                          "Goal",
                          date,
                          rowIndex,
                          tmpTrue,
                          tmpFalse,
                        ),
                        CircleAvatarMenuItems(
                          value,
                          "Skip",
                          date,
                          rowIndex,
                          tmpTrue,
                          tmpFalse,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatarMenuItems(
                          value,
                          "Goal",
                          date,
                          rowIndex,
                          tmpTrue,
                          tmpFalse,
                        ),
                        CircleAvatarMenuItems(
                          value,
                          "Prize",
                          date,
                          rowIndex,
                          tmpTrue,
                          tmpFalse,
                        ),
                        CircleAvatarMenuItems(
                          value,
                          "Skip",
                          date,
                          rowIndex,
                          tmpTrue,
                          tmpFalse,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
