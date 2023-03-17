import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../widgets/paisa_icon_title.dart';
import '../../widgets/paisa_search_button_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import 'home_page.dart';

class HomeMobilePage extends StatefulWidget {
  const HomeMobilePage({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<HomeMobilePage> createState() => _HomeMobilePageState();
}

class _HomeMobilePageState extends State<HomeMobilePage> {
  final HomeBloc homeBloc = getIt.get();
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier =
      ValueNotifier<DateTimeRange?>(null);

  DateTimeRange? dateTimeRange;
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));

    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  void _handleClick() {
    switch (_currentIndex) {
      case 1:
        context.pushNamed('add-account');
        break;
      case 0:
        context.pushNamed(addExpensePath);
        break;

      case 2:
        context.pushNamed(addDebitName);
        break;
      case 3:
        _dateRangePicker();
        break;
    }
  }

  Widget _floatingActionButtonBig() {
    return FloatingActionButton.large(
      onPressed: () => _handleClick(),
      child: _currentIndex != 3
          ? const Icon(Icons.add)
          : const Icon(Icons.date_range),
    );
  }

  Future<void> _dateRangePicker() async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateTimeRange ?? initialDateRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (_, child) {
        return Theme(
          data: ThemeData.from(colorScheme: Theme.of(context).colorScheme)
              .copyWith(
            appBarTheme: Theme.of(context).appBarTheme,
          ),
          child: child!,
        );
      },
    );
    if (newDateRange == null || newDateRange == dateTimeRange) return;
    dateTimeRange = newDateRange;
    dateTimeRangeNotifier.value = newDateRange;
  }

  late final tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: '/home',
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: context.loc.homeLabel,
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/accounts',
      icon: const Icon(Icons.credit_card_outlined),
      activeIcon: const Icon(Icons.credit_card),
      label: context.loc.accountsLabel,
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/debts',
      icon: const Icon(MdiIcons.accountCashOutline),
      activeIcon: const Icon(MdiIcons.accountCash),
      label: context.loc.debtsLabel,
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: '/overview',
      icon: const Icon(Icons.account_balance_wallet_outlined),
      activeIcon: const Icon(Icons.account_balance_wallet),
      label: context.loc.budgetLabel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
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
        body: widget.child,
        floatingActionButton: _floatingActionButtonBig(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: NavigationBar(
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) => _onItemTapped(context, index),
            destinations: tabs,
          ),
        ),
      ),
    );
  }
}
