import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../data/category/model/category.dart';

class CategoryItemMobileWidget extends StatelessWidget {
  const CategoryItemMobileWidget({
    Key? key,
    required this.category,
    required this.onPressed,
  }) : super(key: key);

  final Category category;
  final Function(Category) onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialYouCard(
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          addCategoryScreen,
          arguments: category,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        IconData(
                          category.icon,
                          fontFamily: 'MaterialIcons',
                        ),
                        size: 28,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    category.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 16),
              ],
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
