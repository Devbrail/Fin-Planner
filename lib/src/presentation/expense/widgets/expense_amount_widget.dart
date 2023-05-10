import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction.dart';
import '../../widgets/paisa_text_field.dart';
import '../bloc/expense_bloc.dart';

class ExpenseAmountWidget extends StatelessWidget {
  const ExpenseAmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
        controller: controller,
        hintText: context.loc.amount,
        keyboardType: TextInputType.number,
        maxLength: 13,
        maxLines: 1,
        counterText: '',
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          TextInputFormatter.withFunction((oldValue, newValue) {
            try {
              final text = newValue.text;
              if (text.isNotEmpty) double.parse(text);
              return newValue;
            } catch (e) {}
            return oldValue;
          }),
        ],
        onChanged: (value) {
          double? amount = double.tryParse(value);
          if (BlocProvider.of<ExpenseBloc>(context).transactionType !=
              TransactionType.transfer) {
            BlocProvider.of<ExpenseBloc>(context).expenseAmount = amount;
          } else {
            BlocProvider.of<ExpenseBloc>(context).transferAmount = amount;
          }
        },
        validator: (value) {
          if (value!.isNotEmpty) {
            return null;
          } else {
            return context.loc.validAmount;
          }
        },
      ),
    );
  }
}
