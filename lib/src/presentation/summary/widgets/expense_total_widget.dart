import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../accounts/widgets/account_summary_widget.dart';
import '../../widgets/paisa_card.dart';
import 'expense_total_for_month_widget.dart';
import 'total_balance_widget.dart';

class ExpenseTotalWidget extends StatelessWidget {
  const ExpenseTotalWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final totalExpenseBalance = expenses.fullTotal;
    final totalAccountBalance =
        getIt.get<Box<AccountModel>>().totalAccountInitialAmount;
    final thisMonthExpenses = expenses.thisMonthExpense;
    final thisMonthIncome = expenses.thisMonthIncome;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: PaisaCard(
            elevation: 0,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TotalBalanceWidget(
                    title: context.loc.totalBalance,
                    amount: totalExpenseBalance + totalAccountBalance,
                  ),
                  const SizedBox(height: 32),
                  ExpenseTotalForMonthWidget(
                    outcome: thisMonthExpenses,
                    income: thisMonthIncome,
                  ),
                ],
              ),
            ),
          ),
        ),
        AccountSummaryWidget(expenses: expenses),
      ],
    );
  }
}

class TouchCard extends StatefulWidget {
  const TouchCard({required this.child});

  final Widget child;

  @override
  _TouchCardState createState() => _TouchCardState();
}

class _TouchCardState extends State<TouchCard>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Create the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // Create the animation tween
    _animation = Tween<double>(begin: 1, end: 1.05).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _controller.forward(from: 1);
      },
      onTapCancel: () {
        _controller.reverse(from: 1.05);
      },
      onTapUp: (TapUpDetails details) {
        _controller.reverse(from: 1);
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
