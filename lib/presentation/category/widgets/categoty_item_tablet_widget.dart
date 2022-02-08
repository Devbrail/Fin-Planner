import 'package:flutter/material.dart';

import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/category/model/category.dart';

class CategoryItemTabletWidget extends StatelessWidget {
  const CategoryItemTabletWidget({
    Key? key,
    required this.category,
    required this.onPressed,
  }) : super(key: key);

  final Category category;
  final Function(Category p1) onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialYouCard(
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    IconData(category.icon, fontFamily: 'MaterialIcons'),
                    size: 72,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    category.description,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            category.isPredefined
                ? const SizedBox.shrink()
                : Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        onPressed(category);
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
