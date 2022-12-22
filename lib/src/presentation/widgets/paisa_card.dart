import 'package:flutter/material.dart';

class PaisaCard extends StatelessWidget {
  const PaisaCard({
    super.key,
    required this.child,
    this.elevation,
    this.color,
    this.shape,
  });

  final Widget child;
  final double? elevation;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: color ?? Theme.of(context).colorScheme.surfaceVariant,
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 2.0,
      shadowColor: color ?? Theme.of(context).colorScheme.shadow,
      child: child,
    );
  }
}

class PaisaOutlineCard extends StatelessWidget {
  const PaisaOutlineCard({
    super.key,
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.outline,
              )),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: child,
    );
  }
}

class PaisaFilledCard extends StatelessWidget {
  const PaisaFilledCard({
    super.key,
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: child,
    );
  }
}
