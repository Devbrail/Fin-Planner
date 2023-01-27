import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../service_locator.dart';
import '../../summary/widgets/expense_list_widget.dart';

import '../../../core/common.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: locator.get<Box<Expense>>().listenable(),
      builder: (context, value, child) {
        if (query.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  size: 72,
                ),
                Text(context.loc.searchMessageLabel),
              ],
            ),
          );
        }

        final results = value.values
            .where((Expense c) => c.name.toLowerCase().contains(query))
            .toList();

        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sentiment_satisfied_rounded,
                  size: 72,
                ),
                Text(context.loc.emptySearchMessageLabel),
              ],
            ),
          );
        }
        return results.isEmpty
            ? Center(
                child: Text(
                  context.loc.noResultFoundLabel,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : FutureBuilder<List<dynamic>>(
                future: Future.wait([
                  locator.getAsync<LocalAccountManagerDataSource>(),
                  locator.getAsync<LocalCategoryManagerDataSource>(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ExpenseListWidget(
                      expenses: results,
                      accountLocalDataSource:
                          snapshot.data![0] as LocalAccountManagerDataSource,
                      categoryLocalDataSource:
                          snapshot.data![1] as LocalCategoryManagerDataSource,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
      },
    );
  }
}
