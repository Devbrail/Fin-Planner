import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/src/service_locator.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/context_extensions.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_list_widget.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryBloc>(
      future: locator.getAsync<CategoryBloc>(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final CategoryBloc categoryBloc = snapshot.data!;
          return Scaffold(
            appBar: context.materialYouAppBar(
              AppLocalizations.of(context)!.categoriesLabel,
            ),
            body: ScreenTypeLayout(
              breakpoints: const ScreenBreakpoints(
                tablet: 600,
                desktop: 700,
                watch: 300,
              ),
              mobile: CategoryListWidget(
                addCategoryBloc: categoryBloc,
              ),
              tablet: CategoryListWidget(
                addCategoryBloc: categoryBloc,
                crossAxisCount: 3,
              ),
              desktop: CategoryListWidget(
                addCategoryBloc: categoryBloc,
                crossAxisCount: 5,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
