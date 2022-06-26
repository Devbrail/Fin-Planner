import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/enum/box_types.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/expense/model/expense.dart';
import '../../summary/widgets/expense_list_widget.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable:
          Hive.box<Expense>(BoxType.expense.stringValue).listenable(),
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
                Text(AppLocalizations.of(context)!.searchMessageLable),
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
                Text(AppLocalizations.of(context)!.emptySearchMessageLable),
              ],
            ),
          );
        }
        return results.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.noResultFoundLable,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : ExpenseListWidget(expenses: results);
      },
    );
  }
}
