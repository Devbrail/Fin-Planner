import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/common.dart';
import '../../../core/extensions/filter_expense_extension.dart';
import '../controller/summary_controller.dart';
import '../widgets/filter_home_expense_widget.dart';

class TransactionsHeaderWidget extends StatelessWidget {
  const TransactionsHeaderWidget({
    super.key,
    required this.summaryController,
  });
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      title: Text(
        context.loc.transactions,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          textStyle: Theme.of(context).textTheme.titleLarge,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      trailing: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        label: Text(summaryController.filterHomeExpense.stringValue(context)),
        icon: const Icon(MdiIcons.sortVariant),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width >= 700
                  ? 700
                  : double.infinity,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            builder: (context) {
              return FilterHomeWidget(
                summaryController: summaryController,
              );
            },
          );
        },
      ),
    );
  }
}
