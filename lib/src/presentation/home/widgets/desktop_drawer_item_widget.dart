import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).textTheme.labelLarge?.color;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: isSelected
          ? BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).colorScheme.primaryContainer,
            )
          : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 14,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    );
  }
}
