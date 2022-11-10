import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/context_extensions.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_list_widget.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({
    Key? key,
    required this.addCategoryBloc,
  }) : super(key: key);

  final CategoryBloc addCategoryBloc;

  @override
  CategoryListPageState createState() => CategoryListPageState();
}

class CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
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
          addCategoryBloc: widget.addCategoryBloc,
        ),
        tablet: CategoryListWidget(
          addCategoryBloc: widget.addCategoryBloc,
          crossAxisCount: 3,
        ),
        desktop: CategoryListWidget(
          addCategoryBloc: widget.addCategoryBloc,
          crossAxisCount: 5,
        ),
      ),
    );
  }
}
