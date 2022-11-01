import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/enum/debt_type.dart';
import '../../../common/widgets/empty_widget.dart';
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
  late final TabController controller = TabController(
    length: 2,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(AppLocalizations.of(context)!.debtsLabel),
              pinned: true,
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
              floating: true,
              bottom: TabBar(
                controller: controller,
                labelStyle: Theme.of(context).textTheme.subtitle1,
                labelColor: Theme.of(context).colorScheme.primary,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.debtLabel),
                  Tab(text: AppLocalizations.of(context)!.creditLabel),
                ],
              ),
            ),
          ];
        },
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
              controller: controller,
              children: [
                Builder(
                  builder: (context) {
                    if (debts.isNotEmpty) {
                      return DebtsListWidget(debts: debts);
                    }
                    return EmptyWidget(
                      title: AppLocalizations.of(context)!.emptyDebtsLabel,
                      icon: MdiIcons.cashMinus,
                      description:
                          AppLocalizations.of(context)!.emptyDebtsDescLabel,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    if (debts.isNotEmpty) {
                      return DebtsListWidget(debts: credits);
                    }
                    return EmptyWidget(
                      title: AppLocalizations.of(context)!.emptyCreditLabel,
                      icon: MdiIcons.cashMinus,
                      description:
                          AppLocalizations.of(context)!.emptyCreditDescLabel,
                    );
                  },
                ),
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
