import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../main.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../data/category/model/category.dart';
import '../../../service_locator.dart';
import '../../widgets/future_resolve.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/category_bloc.dart';
import 'category_list_mobile_page.dart';
import 'category_list_tablet_page.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureResolve<CategoryBloc>(
          future: getIt.getAsync<CategoryBloc>(),
          builder: (bloc) => ValueListenableBuilder<Box<Category>>(
            valueListenable: getIt.get<Box<Category>>().listenable(),
            builder: (BuildContext context, value, Widget? child) {
              final categories = value.values.toList();
              if (categories.isEmpty) {
                return EmptyWidget(
                  description: context.loc.errorNoCategoriesDescriptionLabel,
                  icon: Icons.category,
                  title: context.loc.errorNoCatagoriesLabel,
                );
              }
              return ScreenTypeLayout(
                breakpoints: const ScreenBreakpoints(
                  tablet: 600,
                  desktop: 700,
                  watch: 300,
                ),
                mobile: CategoryListMobileWidget(
                  addCategoryBloc: bloc,
                  categories: categories,
                ),
                tablet: CategoryListTabletWidget(
                  addCategoryBloc: bloc,
                  crossAxisCount: 3,
                  categories: categories,
                ),
                desktop: CategoryListTabletWidget(
                  addCategoryBloc: bloc,
                  crossAxisCount: 5,
                  categories: categories,
                ),
              );
            },
          ),
        ),
      );
}
