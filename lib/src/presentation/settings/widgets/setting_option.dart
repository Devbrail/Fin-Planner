import 'package:flutter/material.dart';
import 'package:paisa/src/core/common.dart';

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    Key? key,
    required this.title,
    this.icon,
    this.trailing,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon == null
          ? null
          : Icon(
              icon,
              color: context.onBackground,
            ),
      title: Text(
        title,
        style: TextStyle(
          color: context.onBackground,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: context.onBackground,
              ),
            )
          : null,
      onTap: onTap,
      trailing: trailing,
    );
  }
}
