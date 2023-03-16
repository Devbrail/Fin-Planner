import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/src/domain/expense/entities/expense.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../data/category/data_sources/category_local_data_source.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../summary/widgets/expense_list_widget.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    final categorySource = getIt.get<LocalCategoryManagerDataSource>();
    final accountSource = getIt.get<LocalAccountDataManager>();
    return ValueListenableBuilder<Box<ExpenseModel>>(
      valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
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
            .toEntities()
            .where(
                (Expense expense) => expense.name.toLowerCase().contains(query))
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
        return ExpenseListWidget(
          expenses: results,
          accountLocalDataSource: accountSource,
          categoryLocalDataSource: categorySource,
        );
      },
    );
  }
}

abstract class ListItem {
  const ListItem();

  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class SectionHeader extends ListItem {
  const SectionHeader(this.title);

  final String title;

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildTitle(BuildContext context) => Text(title);
}

class MessageItem extends ListItem {
  const MessageItem(this.title, this.body);

  final String title;
  final String body;

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);

  @override
  Widget buildTitle(BuildContext context) => Text(title);
}
