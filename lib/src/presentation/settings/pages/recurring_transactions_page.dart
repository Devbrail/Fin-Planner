import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/expense/model/expense_model.dart';

class RecurringTransactionPage extends StatelessWidget {
  const RecurringTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('Recurring transactions'),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder<Box<ExpenseModel>>(
              valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
              builder: (_, value, child) {
                final List<ExpenseModel> expenses = value.recurring.toList();
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final ExpenseModel expense = expenses[index];
                    return ListTile(
                      title: Text(expense.name),
                      subtitle: Text(
                          '${expense.recurringType?.name(context) ?? ''} - ${expense.recurringDate?.shortDayString ?? ""}'),
                      trailing: IconButton(
                        onPressed: () async {
                          await expense.delete();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
