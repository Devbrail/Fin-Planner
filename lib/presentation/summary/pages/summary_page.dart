import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../common/enum/box_types.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/settings/settings_service.dart';
import '../../home/widgets/welcome_widget.dart';
import '../../search/pages/search_page.dart';
import '../widgets/expense_history_widget.dart';
import '../widgets/expense_summary_widget.dart';
import '../widgets/expense_total_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder<Box>(
            valueListenable: Hive.box(BoxType.settings.stringValue)
                .listenable(keys: [userNameKey]),
            builder: (context, value, _) {
              final name = value.get(userNameKey, defaultValue: 'Name');
              return Text(
                AppLocalizations.of(context)!.welcomeMessage(name),
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage(),
                );
              },
            ),
            const WelcomeWidget(),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 128),
            children: const [
              ExpenseSummaryWidget(),
              ExpenseTotalWidget(),
              ExpenseHistory(),
            ],
          ),
        ),
        floatingActionButton: floatinActionButton(),
      ),
      tablet: Scaffold(
        appBar: materialYouAppBar(
          context,
          '',
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage(),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    ExpenseSummaryWidget(),
                    ExpenseTotalWidget(),
                  ],
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: ExpenseHistory(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatinActionButton(),
      ),
    );
  }

  FloatingActionButton floatinActionButton() {
    return FloatingActionButton.large(
      onPressed: _addExpense,
      tooltip: AppLocalizations.of(context)!.addExpense,
      heroTag: 'add_expense',
      key: const Key('add_expense'),
      child: const Icon(Icons.add),
    );
  }

  void _addExpense() async => Navigator.pushNamed(context, addExpenseScreen);
}
