import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../di/service_locator.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_list_widget.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  CategoryListPageState createState() => CategoryListPageState();
}

class CategoryListPageState extends State<CategoryListPage> {
  final CategoryBloc addCategoryBloc = locator.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: materialYouAppBar(
        context,
        AppLocalizations.of(context)!.categories,
      ),
      body: ScreenTypeLayout(
        mobile: CategoryListWidget(
          addCategoryBloc: addCategoryBloc,
          crossAxisCount: 2,
        ),
        tablet: CategoryListWidget(
          addCategoryBloc: addCategoryBloc,
          crossAxisCount: 5,
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Navigator.pushNamed(context, addCategoryScreen),
        heroTag: 'add_category',
        key: const Key('add_category'),
        tooltip: AppLocalizations.of(context)!.addCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}
