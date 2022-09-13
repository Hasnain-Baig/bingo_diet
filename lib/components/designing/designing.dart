import 'package:flutter/material.dart';

LinearGradient myLinearGradient(context) {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primary.withOpacity(.6)
      ]);
}

BoxShadow myBoxShadow(context) {
  return BoxShadow(
    color: Theme.of(context).colorScheme.primaryVariant.withOpacity(.1),
    spreadRadius: 4,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  );
}
