import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction.dart';
import '../../widgets/paisa_chip.dart';
import '../bloc/expense_bloc.dart';

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
      buildWhen: (previous, current) => current is ChangeTransactionTypeState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PaisaMaterialYouChip(
                  title: TransactionType.expense.stringName(context),
                  isSelected:
                      expenseBloc.transactionType == TransactionType.expense,
                  onPressed: () => _update(TransactionType.expense),
                ),
                PaisaMaterialYouChip(
                  title: TransactionType.income.stringName(context),
                  isSelected:
                      expenseBloc.transactionType == TransactionType.income,
                  onPressed: () => _update(TransactionType.income),
                ),
                PaisaMaterialYouChip(
                  title: TransactionType.transfer.stringName(context),
                  isSelected:
                      expenseBloc.transactionType == TransactionType.transfer,
                  onPressed: () => _update(TransactionType.transfer),
                ),
                PaisaMaterialYouChip(
                  title: TransactionType.recurring.stringName(context),
                  isSelected:
                      expenseBloc.transactionType == TransactionType.recurring,
                  onPressed: () => _update(TransactionType.recurring),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
