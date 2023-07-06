import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/category/model/category_model.dart';
import '../../widgets/paisa_card.dart';

class CategoryItemTabletWidget extends StatelessWidget {
  const CategoryItemTabletWidget({
    Key? key,
    required this.category,
    required this.onPressed,
  }) : super(key: key);

  final CategoryModel category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PaisaFilledCard(
      child: InkWell(
        onTap: () => context.pushNamed(
          editCategoryName,
          pathParameters: <String, String>{'cid': category.superId.toString()},
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                IconData(
                  category.icon,
                  fontFamily: fontFamilyName,
                  fontPackage: fontFamilyPackageName,
                ),
                color: Color(category.color ?? context.primary.value),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    if (category.description != null)
                      Text(
                        category.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelMedium?.copyWith(
                          color: context.onSurface.withOpacity(0.55),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
