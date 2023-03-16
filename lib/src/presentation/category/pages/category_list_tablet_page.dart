import 'package:flutter/material.dart';

import '../../../domain/category/entities/category.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_item_tablet_widget.dart';

class CategoryListTabletWidget extends StatelessWidget {
  const CategoryListTabletWidget({
    Key? key,
    required this.addCategoryBloc,
    this.crossAxisCount = 1,
    required this.categories,
  }) : super(key: key);

  final CategoryBloc addCategoryBloc;
  final int crossAxisCount;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) => GridView.builder(
        padding: const EdgeInsets.only(
          bottom: 124,
          left: 8,
          right: 8,
          top: 8,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => CategoryItemTabletWidget(
          category: categories[index],
          onPressed: () =>
              addCategoryBloc.add(CategoryDeleteEvent(categories[index])),
        ),
      );
}
