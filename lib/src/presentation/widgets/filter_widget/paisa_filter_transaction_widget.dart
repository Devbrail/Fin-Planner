import 'package:flutter/material.dart';
import 'package:flutter_paisa/src/core/enum/filter_budget.dart';
import 'package:flutter_paisa/src/presentation/widgets/filter_widget/filter_budget_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final ValueNotifier<FilterBudget> valueNotifier =
    ValueNotifier<FilterBudget>(FilterBudget.daily);

class PaisaFilterTransactionWidget extends StatelessWidget {
  const PaisaFilterTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Column(
                children: [
                  FilterBudgetToggleWidget(
                    valueNotifier: valueNotifier,
                    showAsList: true,
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(MdiIcons.filter),
    );
  }
}
