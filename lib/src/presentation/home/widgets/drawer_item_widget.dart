import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.title,
    required this.icon,
  });
  final bool isSelected;
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Theme.of(context).colorScheme.secondaryContainer,
              )
            : null,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer
                              : null,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
