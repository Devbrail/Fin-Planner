import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/src/core/enum/transaction.dart';

import '../../../core/enum/recurring_type.dart';
import '../../widgets/paisa_chip.dart';
import '../bloc/expense_bloc.dart';

class ExpenseRecurringWidget extends StatelessWidget {
  const ExpenseRecurringWidget({
    super.key,
    required this.expenseBloc,
  });
  final ExpenseBloc expenseBloc;
  void _update(RecurringType type) {
    expenseBloc.add(ChangeRecurringEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ExpenseBloc>(context),
      buildWhen: (oldState, newState) =>
          newState is ChangeRecurringTypeState ||
          newState is ChangeTransactionTypeState,
      builder: (context, state) {
        if (state is ChangeTransactionTypeState &&
            state.transactionType == TransactionType.transfer) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Periodic',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    PaisaMaterialYouChip(
                      title: RecurringType.daily.name(context),
                      isSelected:
                          expenseBloc.recurringType == RecurringType.daily,
                      onPressed: () => _update(RecurringType.daily),
                    ),
                    PaisaMaterialYouChip(
                      title: RecurringType.weekly.name(context),
                      isSelected:
                          expenseBloc.recurringType == RecurringType.weekly,
                      onPressed: () => _update(RecurringType.weekly),
                    ),
                    PaisaMaterialYouChip(
                      title: RecurringType.monthly.name(context),
                      isSelected:
                          expenseBloc.recurringType == RecurringType.monthly,
                      onPressed: () => _update(RecurringType.monthly),
                    ),
                    PaisaMaterialYouChip(
                      title: RecurringType.yearly.name(context),
                      isSelected:
                          expenseBloc.recurringType == RecurringType.yearly,
                      onPressed: () => _update(RecurringType.yearly),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
