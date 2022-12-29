import 'package:flutter/material.dart';
import '../../widgets/paisa_search_bar.dart';

import '../../../core/enum/filter_budget.dart';
import '../../widgets/color_palette.dart';
import '../../home/widgets/welcome_widget.dart';
import '../../settings/widgets/user_profile_widget.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_total_widget.dart';
import '../widgets/welcome_name_widget.dart';

class SummaryDesktopPage extends StatelessWidget {
  const SummaryDesktopPage({
    super.key,
    required this.valueNotifier,
  });
  final ValueNotifier<FilterBudget> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width >= 700
                          ? 700
                          : double.infinity,
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    context: context,
                    builder: (_) => const UserProfilePage(),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ColorPalette(),
                            ),
                          );
                        },
                        child: const WelcomeWidget(),
                      ),
                      const WelcomeNameWidget(),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    PaisaSearchBar(),
                    SizedBox(width: 24),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: ExpenseTotalWidget(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpenseHistory(
                        valueNotifier: valueNotifier,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
