import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../widgets/paisa_text_field.dart';
import '../bloc/transaction_bloc.dart';

class TransactionNameWidget extends StatelessWidget {
  const TransactionNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      buildWhen: (oldState, newState) => newState is ChangeTransactionTypeState,
      builder: (context, state) {
        if (state is ChangeTransactionTypeState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PaisaTextFormField(
              maxLines: 1,
              controller: controller,
              hintText: state.transactionType.hintName(context),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return context.loc.validName;
                }
              },
              onChanged: (value) =>
                  BlocProvider.of<TransactionBloc>(context).expenseName = value,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
