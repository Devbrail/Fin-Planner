import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/debt_toggle_buttons_widget.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/enum/debt_type.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../../../data/debt/models/debt.dart';
import '../../../di/service_locator.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.debtsLabel),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.bold),
        actions: [
          DebtToggleButtonsWidget(
            onSelected: (type) {
              setState(() {
                selectedType = type;
              });
            },
            selectedType: selectedType,
          )
        ],
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

          return Builder(
            builder: (context) {
              if (selectedType == DebtType.debt) {
                return debts.isNotEmpty
                    ? DebtsListWidget(debts: debts)
                    : EmptyWidget(
                        title: AppLocalizations.of(context)!.emptyDebtsLabel,
                        icon: MdiIcons.cashMinus,
                        description:
                            AppLocalizations.of(context)!.emptyDebtsDescLabel,
                      );
              }
              if (selectedType == DebtType.credit) {
                return credits.isNotEmpty
                    ? DebtsListWidget(debts: credits)
                    : EmptyWidget(
                        title: AppLocalizations.of(context)!.emptyCreditLabel,
                        icon: MdiIcons.cashMinus,
                        description:
                            AppLocalizations.of(context)!.emptyCreditDescLabel,
                      );
              }
              return EmptyWidget(
                title: AppLocalizations.of(context)!.emptyDebtsLabel,
                icon: MdiIcons.cashMinus,
                description: AppLocalizations.of(context)!.emptyDebtsDescLabel,
              );
            },
          );
        },
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
