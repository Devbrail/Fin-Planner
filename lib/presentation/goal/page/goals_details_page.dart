import 'package:flutter/material.dart';
import 'package:flutter_paisa/app/routes.dart';
import 'package:flutter_paisa/common/constants/constants.dart';
import 'package:flutter_paisa/common/constants/currency.dart';
import 'package:flutter_paisa/data/accounts/datasources/account_data_source.dart';
import 'package:flutter_paisa/data/expense/model/expense.dart';
import 'package:flutter_paisa/di/service_locator.dart';
import 'package:flutter_paisa/presentation/summary/widgets/expense_item_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/enum/box_types.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/goals/model/goal.dart';

class GoalsDetailsPage extends StatefulWidget {
  const GoalsDetailsPage({super.key, required this.goal});

  final Goal goal;

  @override
  State<GoalsDetailsPage> createState() => _GoalsDetailsPageState();
}

class _GoalsDetailsPageState extends State<GoalsDetailsPage> {
  late final goals = Hive.box<Goal>(BoxType.goals.stringValue);
  final AccountDataSource dataSource = locator.get();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Expense>>(
        valueListenable:
            Hive.box<Expense>(BoxType.expense.stringValue).listenable(),
        builder: (_, value, __) {
          final List<Expense> expenses = value.values
              .where((element) => element.isGoalExpense)
              .where((element) => element.goalId == widget.goal.superId)
              .toList();
          if (goals.isEmpty) {
            return Text('data');
          }
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  title: Text(
                    widget.goal.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  floating: true,
                  pinned: true,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top +
                            kToolbarHeight),
                    child: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(widget.goal.description),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Goad: ${formattedCurrency(widget.goal.amount)}',
                              style: GoogleFonts.manrope(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  expandedHeight: 200,
                  actions: [
                    IconButton(
                      onPressed: () {
                        goals.delete(widget.goal.superId);
                        GoRouter.of(context).pop();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final expense = expenses[index];
                      final account =
                          dataSource.fetchAccount(expense.accountId);
                      return ExpensItemWidget(
                        expense: expense,
                        account: account,
                      );
                    },
                    childCount: expenses.length,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.large(
              onPressed: () async {
                context.pushNamed(
                  addExpensePath,
                  queryParams: {
                    addGoalExpense: 'true',
                    goalId: widget.goal.superId!.toString(),
                  },
                );
              },
              tooltip: AppLocalizations.of(context)!.addExpenseLable,
              heroTag: 'add_expense',
              key: const Key('add_expense'),
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
