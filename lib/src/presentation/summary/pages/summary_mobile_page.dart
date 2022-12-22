import 'package:flutter/material.dart';
import 'package:flutter_paisa/src/presentation/widgets/paisa_search_button_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/enum/filter_budget.dart';
import '../../widgets/filter_widget/filter_budget_widget.dart';
import '../../widgets/paisa_title_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryMobilePage extends StatelessWidget {
  const SummaryMobilePage({
    super.key,
    required this.valueNotifier,
  });
  final ValueNotifier<FilterBudget> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(bottom: 124),
        children: [
          const WelcomeNameWidget(),
          const ExpenseTotalWidget(),
          const SizedBox(height: 8),
          FilterBudgetToggleWidget(valueNotifier: valueNotifier),
          ExpenseHistory(valueNotifier: valueNotifier),
        ],
      ),
    );
  }
}
