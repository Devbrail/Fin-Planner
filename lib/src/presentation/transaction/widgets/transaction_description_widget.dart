import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../widgets/paisa_text_field.dart';
import '../bloc/transaction_bloc.dart';

class ExpenseDescriptionWidget extends StatelessWidget {
  const ExpenseDescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
        maxLines: 1,
        controller: controller,
        hintText: context.loc.description,
        keyboardType: TextInputType.name,
        onChanged: (value) => BlocProvider.of<TransactionBloc>(context)
            .currentDescription = value,
      ),
    );
  }
}
