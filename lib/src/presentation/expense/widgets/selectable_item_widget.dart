import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.subtitle,
  });

  final bool isSelected;
  final String title;
  final String? subtitle;
  final int icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final shape = isSelected
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          );
    return SizedBox(
      width: 150,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    IconData(
                      icon,
                      fontFamily: 'Material Design Icons',
                      fontPackage: 'material_design_icons_flutter',
                    ),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: subtitle != null ? Text(subtitle!) : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
