import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../summary/controller/summary_controller.dart';
import '../bloc/home_bloc.dart';

class PaisaActionButton extends StatelessWidget {
  const PaisaActionButton({
    super.key,
    required this.summaryController,
    required this.settings,
  });

  final SummaryController summaryController;
  final Box<dynamic> settings;
  void _handleClick(BuildContext context, PageType page) {
    switch (page) {
      case PageType.accounts:
        context.goNamed(addAccountName);
        break;
      case PageType.home:
        context.pushNamed(addTransactionsName);
        break;
      case PageType.category:
        context.goNamed(addCategoryName);
        break;
      case PageType.debts:
        context.goNamed(addDebitName);
        break;
      case PageType.overview:
        _dateRangePicker(context);
        break;
      case PageType.budget:
        break;
    }
  }

  Future<void> _dateRangePicker(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      initialDateRange: initialDateRange,
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
    if (newDateRange == null) return;
    summaryController.dateTimeRangeNotifier.value = newDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<HomeBloc>(context),
      builder: (context, state) {
        if (state is CurrentIndexState &&
            state.currentPage != PageType.budget) {
          if (settings.get(smallSizeFab, defaultValue: false)) {
            return FloatingActionButton(
              tooltip: state.currentPage.toolTip(context),
              onPressed: () => _handleClick(context, state.currentPage),
              child: state.currentPage != PageType.overview
                  ? const Icon(Icons.add)
                  : const Icon(Icons.date_range),
            );
          } else {
            return FloatingActionButton.large(
              tooltip: state.currentPage.toolTip(context),
              onPressed: () => _handleClick(context, state.currentPage),
              child: state.currentPage != PageType.overview
                  ? const Icon(Icons.add)
                  : const Icon(Icons.date_range),
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
