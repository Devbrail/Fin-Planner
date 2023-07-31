import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/transaction/presentation/bloc/transaction_bloc.dart';

import 'package:paisa/core/widgets/paisa_widget.dart';

class TransactionNameWidget extends StatelessWidget {
  const TransactionNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      buildWhen: (TransactionState oldState, TransactionState newState) => newState is ChangeTransactionTypeState,
      builder: (BuildContext context, TransactionState state) {
        String hintName = TransactionType.expense.hintName(context);
        if (state is ChangeTransactionTypeState) {
          hintName = state.transactionType.hintName(context);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PaisaTextFormField(
            maxLines: 1,
            controller: controller,
            hintText: hintName,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            validator: (String? value) {
              if (value!.isNotEmpty) {
                return null;
              } else {
                return context.loc.validName;
              }
            },
            onChanged: (String value) =>
                BlocProvider.of<TransactionBloc>(context).expenseName = value,
          ),
        );
      },
    );
  }
}
