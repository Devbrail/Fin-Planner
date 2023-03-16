import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../domain/category/entities/category.dart';
import '../../widgets/paisa_bottom_sheet.dart';
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
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 124,
          left: 8,
          right: 8,
          top: 8,
        ),
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => CategoryItemMobileWidget(
          category: categories[index],
          onPressed: () => paisaAlertDialog(
            context,
            title: Text(context.loc.dialogDeleteTitleLabel),
            child: RichText(
              text: TextSpan(
                text: context.loc.deleteCategoryLabel,
                children: [
                  TextSpan(
                      text: categories[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            confirmationButton: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                addCategoryBloc.add(CategoryDeleteEvent(categories[index]));
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ),
        ),
      );
}
