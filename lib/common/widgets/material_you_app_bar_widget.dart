import 'package:flutter/material.dart';

AppBar materialYouAppBar(
  BuildContext context,
  String title, {
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title),
    titleTextStyle: Theme.of(context)
        .textTheme
        .headline6
        ?.copyWith(fontWeight: FontWeight.bold),
    backgroundColor: Colors.transparent,
    actions: actions ?? [],
  );
}
