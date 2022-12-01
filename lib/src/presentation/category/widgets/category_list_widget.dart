import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../data/category/model/category.dart';
import '../../../service_locator.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/category_bloc.dart';
import 'category_item_desktop_widget.dart';
import 'category_item_mobile_widget.dart';
import 'category_item_tablet_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    Key? key,
    required this.addCategoryBloc,
    this.crossAxisCount = 1,
  }) : super(key: key);

  final CategoryBloc addCategoryBloc;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Category>>(
      valueListenable: locator.get<Box<Category>>().listenable(),
      builder: (BuildContext context, value, Widget? child) {
        final categories = value.values.toList();
        if (categories.isEmpty) {
          return EmptyWidget(
            description:
                AppLocalizations.of(context)!.errorNoCategoriesDescriptionLabel,
            icon: Icons.category,
            title: AppLocalizations.of(context)!.errorNoCatagoriesLabel,
          );
        }
        return ScreenTypeLayout(
          breakpoints: const ScreenBreakpoints(
            tablet: 600,
            desktop: 700,
            watch: 300,
          ),
          mobile: ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 124,
              left: 8,
              right: 8,
              top: 8,
            ),
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final category = categories[index];
              return CategoryItemMobileWidget(
                category: category,
                onPressed: (category) {
                  addCategoryBloc.add(CategoryDeleteEvent(category));
                },
              );
            },
          ),
          tablet: GridView.builder(
            padding: const EdgeInsets.only(
              bottom: 124,
              left: 8,
              right: 8,
              top: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final category = categories[index];
              return CategoryItemTabletWidget(
                category: category,
                onPressed: (category) {
                  addCategoryBloc.add(CategoryDeleteEvent(category));
                },
              );
            },
          ),
          desktop: GridView.builder(
            padding: const EdgeInsets.only(
              bottom: 124,
              left: 8,
              right: 8,
              top: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: categories.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final category = categories[index];
              return CategoryItemDesktopWidget(
                category: category,
                onPressed: (category) {
                  addCategoryBloc.add(CategoryDeleteEvent(category));
                },
              );
            },
          ),
        );
      },
    );
  }
}
