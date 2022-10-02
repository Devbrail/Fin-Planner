import 'package:flutter/material.dart';

AppBar materialYouAppBar(BuildContext context, String title,
    {List<Widget>? actions, Widget? leadingWidget}) {
  return AppBar(
    leading: leadingWidget,
    title: Text(title),
    titleTextStyle: Theme.of(context)
        .textTheme
        .headline6
        ?.copyWith(fontWeight: FontWeight.bold),
    backgroundColor: Colors.transparent,
    actions: actions ?? [],
  );
}

showMaterialSnackBar(
  BuildContext context,
  String content, {
  Color? backgroundColor,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text(
        content,
        style: TextStyle(
          color: color ?? Theme.of(context).colorScheme.onSurface,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      elevation: 20,
    ),
  );
}
