import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
          future: locator.getAsync<CategoryBloc>(),
          builder: (bloc) {
            return ValueListenableBuilder<Box<Category>>(
              valueListenable: locator.get<Box<Category>>().listenable(),
              builder: (BuildContext context, value, Widget? child) {
                final categories = value.values.toList();
                if (categories.isEmpty) {
                  return EmptyWidget(
                    description: AppLocalizations.of(context)!
                        .errorNoCategoriesDescriptionLabel,
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
            );
          },
        ),
      );
}
