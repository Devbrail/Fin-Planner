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
        : Theme.of(context).textTheme.button?.color;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 4,
            height: 62,
            decoration: isSelected
                ? BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
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
    );
  }
}
