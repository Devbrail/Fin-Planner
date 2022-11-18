import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../data/category/model/category.dart';
import '../../widgets/paisa_card.dart';

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
    return PaisaCard(
      child: ListTile(
        onTap: () => context.goNamed(
          editCategoryPath,
          params: <String, String>{'cid': category.superId.toString()},
        ),
        leading: Icon(
          IconData(
            category.icon,
            fontFamily: 'Material Design Icons',
            fontPackage: 'material_design_icons_flutter',
          ),
          size: 28,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          category.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        subtitle: Text(
          category.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.75),
              ),
        ),
        trailing: IconButton(
          onPressed: () {
            onPressed(category);
          },
          icon: Icon(
            Icons.delete_rounded,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
