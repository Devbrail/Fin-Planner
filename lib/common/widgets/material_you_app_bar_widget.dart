import 'package:flutter/material.dart';

AppBar materialYouAppBar(
  BuildContext context,
  String title, {
  List<Widget>? actions,
}) {
  return AppBar(
    iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
    title: Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.bold),
    ),
    actions: actions ?? [],
  );
}
