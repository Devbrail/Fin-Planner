import 'package:flutter/material.dart';

class PaisaToggleButton extends StatelessWidget {
  const PaisaToggleButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Theme.of(context).colorScheme.primary : null;
    final color =
        isSelected ? Theme.of(context).colorScheme.primaryContainer : null;
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(14.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
