import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt.dart';
import '../../../service_locator.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../widgets/debt_item_widget.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key});

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage>
    with SingleTickerProviderStateMixin {
  DebtType selectedType = DebtType.debt;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Material(
                borderRadius: BorderRadius.circular(32),
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(32),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.debtLabel),
                    Tab(text: AppLocalizations.of(context)!.creditLabel),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<Debt>>(
          valueListenable: locator.get<Box<Debt>>().listenable(),
          builder: (context, value, child) {
            final debts = value.values
                .where((element) => element.debtType == DebtType.debt)
                .toList();

            final credits = value.values
                .where((element) => element.debtType == DebtType.credit)
                .toList();

            return TabBarView(
              children: [
                Builder(
                  builder: (context) {
                    return debts.isNotEmpty
                        ? DebtsListWidget(debts: debts)
                        : EmptyWidget(
                            title:
                                AppLocalizations.of(context)!.emptyDebtsLabel,
                            icon: MdiIcons.cashMinus,
                            description: AppLocalizations.of(context)!
                                .emptyDebtsDescLabel,
                          );
                  },
                ),
                Builder(
                  builder: (context) {
                    return credits.isNotEmpty
                        ? DebtsListWidget(debts: credits)
                        : EmptyWidget(
                            title:
                                AppLocalizations.of(context)!.emptyCreditLabel,
                            icon: MdiIcons.cashMinus,
                            description: AppLocalizations.of(context)!
                                .emptyCreditDescLabel,
                          );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class DebtsListWidget extends StatelessWidget {
  final List<Debt> debts;

  const DebtsListWidget({
    super.key,
    required this.debts,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      itemCount: debts.length,
      itemBuilder: (context, index) => DebtItemWidget(
        debt: debts[index],
      ),
    );
  }
}
