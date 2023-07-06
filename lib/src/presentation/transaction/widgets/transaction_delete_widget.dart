import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common.dart';

import '../../widgets/paisa_bottom_sheet.dart';
import '../bloc/transaction_bloc.dart';

class TransactionDeleteWidget extends StatelessWidget {
  const TransactionDeleteWidget({super.key, required this.expenseId});
  final String? expenseId;
  @override
  Widget build(BuildContext context) {
    if (expenseId == null) {
      return const SizedBox.shrink();
    } else {
      return IconButton(
        onPressed: () => paisaAlertDialog(
          context,
          title: Text(context.loc.dialogDeleteTitle),
          child: RichText(
            text: TextSpan(
              text: context.loc.deleteExpense,
              style: context.bodyLarge,
            ),
          ),
          confirmationButton: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: () {
              BlocProvider.of<TransactionBloc>(context)
                  .add(ClearExpenseEvent(expenseId!));
              Navigator.pop(context);
            },
            child: Text(context.loc.delete),
          ),
        ),
        icon: Icon(
          Icons.delete_rounded,
          color: context.error,
        ),
      );
    }
  }
}
