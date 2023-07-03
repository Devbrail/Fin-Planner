import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/category/model/category_model.dart';
import '../../../domain/category/entities/category.dart';
import '../../widgets/paisa_annotate_region_widget.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/category_bloc.dart';
import 'category_list_mobile_page.dart';
import 'category_list_tablet_page.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt.get<CategoryBloc>();
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        body: ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
          builder: (BuildContext context, value, Widget? child) {
            final List<Category> categories =
                value.values.filterDefault.toEntities();
            if (categories.isEmpty) {
              return EmptyWidget(
                title: context.loc.emptyCategoriesMessageTitle,
                description: context.loc.emptyCategoriesMessageSubTitle,
                icon: Icons.category,
              );
            }
            return ScreenTypeLayout(
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
}
