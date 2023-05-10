import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../../core/enum/debt_type.dart';
import '../../widgets/paisa_chip.dart';
import '../cubit/debts_cubit.dart';

class DebtToggleButtonsWidget extends StatelessWidget {
  const DebtToggleButtonsWidget({
    Key? key,
    required this.debtsBloc,
  }) : super(key: key);
  final DebtsBloc debtsBloc;

  void _update(DebtType type) {
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
            PaisaMaterialYouChip(
              title: DebtType.debt.stringValue(context),
              isSelected: debtsBloc.currentDebtType == DebtType.debt,
              onPressed: () => _update(DebtType.debt),
            ),
            PaisaMaterialYouChip(
              title: DebtType.credit.stringValue(context),
              isSelected: debtsBloc.currentDebtType == DebtType.credit,
              onPressed: () => _update(DebtType.credit),
            ),
          ],
        );
      },
    );
  }
}
