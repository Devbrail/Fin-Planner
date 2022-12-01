import 'package:flutter/material.dart';

import '../../../service_locator.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_list_widget.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CategoryBloc>(
        future: locator.getAsync<CategoryBloc>(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final CategoryBloc categoryBloc = snapshot.data!;
            return CategoryListWidget(
              addCategoryBloc: categoryBloc,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
