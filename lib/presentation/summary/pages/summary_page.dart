import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../home/bloc/home_bloc.dart';
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
          title: BlocBuilder(
            buildWhen: (previous, current) =>
                current is UserDetailsChangedState,
            bloc: BlocProvider.of<HomeBloc>(context),
            builder: (context, state) {
              String name = '';
              if (state is UserDetailsChangedState) {
                name = state.name;
              }
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  void _addExpense() async => Navigator.pushNamed(context, addExpenseScreen);
}
