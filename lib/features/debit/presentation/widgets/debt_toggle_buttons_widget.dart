import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/core/enum/debt_type.dart';
import 'package:paisa/core/extensions/debit_extensions.dart';
import 'package:paisa/features/debit/presentation/cubit/debts_bloc.dart';

import 'package:paisa/core/widgets/paisa_widget.dart';

class DebtToggleButtonsWidget extends StatelessWidget {
  const DebtToggleButtonsWidget({
    Key? key,
    required this.debtsBloc,
  }) : super(key: key);

  final DebitBloc debtsBloc;

  void _update(DebitType type) {
    debtsBloc.add(ChangeDebtTypeEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: debtsBloc,
      buildWhen: (previous, current) => current is DebtsTabState,
      builder: (context, state) {
        return Row(
          children: [
            PaisaPillChip(
              title: DebitType.debit.stringValue(context),
              isSelected: debtsBloc.currentDebtType == DebitType.debit,
              onPressed: () => _update(DebitType.debit),
            ),
            PaisaPillChip(
              title: DebitType.credit.stringValue(context),
              isSelected: debtsBloc.currentDebtType == DebitType.credit,
              onPressed: () => _update(DebitType.credit),
            ),
          ],
        );
      },
    );
  }
}
