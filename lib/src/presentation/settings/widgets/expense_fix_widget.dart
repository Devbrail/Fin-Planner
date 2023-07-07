import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../cubit/settings_cubit.dart';

class FixExpenseWidget extends StatelessWidget {
  const FixExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => BlocProvider.of<SettingCubit>(context).fixExpenses(),
      title: const Text('Fix transfer expenses'),
      trailing: BlocConsumer<SettingCubit, SettingsState>(
        listener: (context, state) {
          if (state is ExpenseFixError) {
            context.showMaterialSnackBar('Add transfer category');
          }
        },
        builder: (context, state) {
          if (state is ExpenseFixStarted) {
            return const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
