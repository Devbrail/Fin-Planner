import 'package:flutter/material.dart';
import 'package:flutter_paisa/common/widgets/material_you_app_bar_widget.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/enum/box_types.dart';
import '../../../data/accounts/data_sources/account_local_data_source.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../../summary/widgets/expense_item_widget.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({
    super.key,
    required this.categoryId,
  });

  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final int? cid = int.tryParse(categoryId ?? '');
    return Scaffold(
      appBar: materialYouAppBar(
        context,
        AppLocalizations.of(context)!.expenseByCategoryLabel,
      ),
      body: ValueListenableBuilder<Box<Expense>>(
        valueListenable:
            Hive.box<Expense>(BoxType.expense.stringValue).listenable(),
        builder: (context, value, _) {
          final expenses = value.values
              .where((element) => element.categoryId == cid)
              .toList();
          if (expenses.isEmpty) {
            return const Text('No data');
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: expenses.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpenseItemWidget(
                expense: expenses[index],
                account: locator
                    .get<AccountLocalDataSource>()
                    .fetchAccount(expenses[index].accountId),
              );
            },
          );
        },
      ),
    );
  }
}
