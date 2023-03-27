import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/expense_bloc.dart';

import '../../../core/enum/transaction.dart';
import '../../widgets/paisa_chip.dart';

class TransactionToggleButtons extends StatelessWidget {
  const TransactionToggleButtons({
    Key? key,
    required this.expenseBloc,
  }) : super(key: key);

  final ExpenseBloc expenseBloc;

  void _update(TransactionType type) {
    expenseBloc.add(ChangeExpenseEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: expenseBloc,
      buildWhen: (previous, current) => current is ChangeExpenseState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              PaisaMaterialYouChip(
                title: TransactionType.expense.name(context),
                isSelected:
                    expenseBloc.transactionType == TransactionType.expense,
                onPressed: () => _update(TransactionType.expense),
              ),
              PaisaMaterialYouChip(
                title: TransactionType.income.name(context),
                isSelected:
                    expenseBloc.transactionType == TransactionType.income,
                onPressed: () => _update(TransactionType.income),
              ),
            ],
          ),
        );
      },
    );
  }
}
