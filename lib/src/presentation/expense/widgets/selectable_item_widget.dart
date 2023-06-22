import 'package:flutter/material.dart';

import '../../../core/common.dart';

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
              color: context.primary,
              width: 2,
            ),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          );
    return SizedBox(
      width: 150,
      child: Card(
        color: context.surface,
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
                  backgroundColor: context.primary,
                  child: Icon(
                    IconData(
                      icon,
                      fontFamily: fontFamilyName,
                      fontPackage: fontFamilyPackageName,
                    ),
                    color: context.onPrimary,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                title: Text(
                  title,
                  style: context.titleMedium?.copyWith(
                    color: context.onSurface,
                  ),
                ),
                subtitle: subtitle != null
                    ? Text(
                        subtitle!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
