import 'package:flutter/material.dart';

import '../../../domain/category/entities/category.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_item_mobile_widget.dart';

class CategoryListMobileWidget extends StatelessWidget {
  const CategoryListMobileWidget({
    Key? key,
    required this.addCategoryBloc,
    required this.categories,
  }) : super(key: key);

  final CategoryBloc addCategoryBloc;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        indent: 72,
      ),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 124),
      itemCount: categories.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return CategoryItemMobileWidget(category: categories[index]);
      },
    );
  }
}
