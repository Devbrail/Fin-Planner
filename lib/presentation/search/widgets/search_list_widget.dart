import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      valueListenable: Hive.box<Expense>('expense').listenable(),
      builder: (BuildContext context, value, Widget? child) {
        var results = query.isEmpty
            ? value.values.toList() // whole list
            : value.values.where((Expense c) {
                return c.name.toLowerCase().contains(query);
              }).toList();
        return results.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.noResultFound,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : ExpenseListWidget(expenses: results);
      },
    );
  }
}
