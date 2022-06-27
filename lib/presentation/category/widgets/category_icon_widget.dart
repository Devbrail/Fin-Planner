import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/widgets/show_icon_picker.dart';

class CategoryIcons extends StatefulWidget {
  const CategoryIcons({
    Key? key,
    required this.onSeleted,
  }) : super(key: key);

  final Function(IconData iconData) onSeleted;

  @override
  CategoryIconsState createState() => CategoryIconsState();
}

class CategoryIconsState extends State<CategoryIcons> {
  IconData selectedIcon = Icons.fastfood_rounded;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: defaultCategoryIcons.take(9).length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index) {
        var iconData = defaultCategoryIcons[index];
        return ScreenTypeLayout(
          mobile: IconButton(
            onPressed: () async {
              if (index == defaultCategoryIcons.length - 1) {
                final icon = await showIconPicker(
                  context: context,
                  defaultIcon: selectedIcon,
                );
                if (icon != null) {
                  selectedIcon = icon;
                  widget.onSeleted(selectedIcon);
                  setState(() {});
                }
                return;
              }
              selectedIcon = iconData;
              widget.onSeleted(iconData);
              setState(() {});
            },
            icon: Icon(
              iconData,
              color: selectedIcon == iconData
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
          tablet: Card(
            shape: selectedIcon == iconData
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  )
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIcon = iconData;
                });
                widget.onSeleted(iconData);
              },
              child: Icon(
                iconData,
                size: 32,
                color: selectedIcon == iconData
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
