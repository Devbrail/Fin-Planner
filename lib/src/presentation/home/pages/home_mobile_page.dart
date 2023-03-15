import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/common.dart';
import '../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../widgets/paisa_icon_title.dart';
import '../../widgets/paisa_search_button_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({
    super.key,
    required this.homeBloc,
    required this.dateTimeRangeNotifier,
    required this.floatingActionButton,
  });

  final HomeBloc homeBloc;
  final Widget floatingActionButton;
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PaisaIconTitle(),
        actions: [
          const PaisaFilterTransactionWidget(),
          const PaisaSearchButtonWidget(),
          PaisaUserWidget(
            homeBloc: homeBloc,
          ),
        ],
      ),
      body: ContentWidget(
        dateTimeRangeNotifier: dateTimeRangeNotifier,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BlocBuilder(
        bloc: homeBloc,
        builder: (context, state) => Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: NavigationBar(
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedIndex: homeBloc.getIndexFromPage(homeBloc.currentPage),
            onDestinationSelected: (index) => homeBloc
                .add(CurrentIndexEvent(homeBloc.getPageFromIndex(index))),
            destinations: [
              NavigationDestination(
                label: context.loc.homeLabel,
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
              ),
              NavigationDestination(
                label: context.loc.accountsLabel,
                icon: const Icon(Icons.credit_card_outlined),
                selectedIcon: const Icon(Icons.credit_card),
              ),
              NavigationDestination(
                label: context.loc.debtsLabel,
                icon: const Icon(MdiIcons.accountCash),
                selectedIcon: const Icon(MdiIcons.accountCashOutline),
              ),
              NavigationDestination(
                label: context.loc.budgetLabel,
                icon: const Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: const Icon(Icons.account_balance_wallet),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
