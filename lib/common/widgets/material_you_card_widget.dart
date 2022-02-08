import 'package:flutter/material.dart';

class MaterialYouCard extends StatelessWidget {
  const MaterialYouCard({
    Key? key,
    required this.child,
    this.color,
    this.elevation,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: color ?? Theme.of(context).colorScheme.surfaceVariant,
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 2.0,
      shadowColor: color ?? Theme.of(context).colorScheme.shadow,
      child: child,
    );
  }
}
