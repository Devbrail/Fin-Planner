import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaisaBigButton extends StatelessWidget {
  const PaisaBigButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
        ),
      ),
    );
  }
}

class PaisaButton extends StatelessWidget {
  const PaisaButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(title),
    );
  }
}

class PaisaIconButton extends StatelessWidget {
  const PaisaIconButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconData,
  });

  final VoidCallback onPressed;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      label: Text(title),
      icon: Icon(iconData),
    );
  }
}

class PaisaTextButton extends StatelessWidget {
  const PaisaTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(title),
    );
  }
}

class PaisaOutlineButton extends StatelessWidget {
  const PaisaOutlineButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(title),
    );
  }
}

class PaisaOutlineIconButton extends StatelessWidget {
  const PaisaOutlineIconButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      label: Text(title),
      icon: const Icon(MdiIcons.sortVariant),
    );
  }
}
