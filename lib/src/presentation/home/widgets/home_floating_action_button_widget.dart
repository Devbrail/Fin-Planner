import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../app/routes.dart';
import '../../summary/controller/summary_controller.dart';
import '../../widgets/small_size_fab.dart';
import '../bloc/home_bloc.dart';

class HomeFloatingActionButtonWidget extends StatelessWidget {
  const HomeFloatingActionButtonWidget({
    super.key,
    required this.summaryController,
    required this.settings,
  });

  final Box<dynamic> settings;
  final SummaryController summaryController;

  void _handleClick(BuildContext context, int page) {
    switch (page) {
      case 1:
        context.goNamed(addAccountName);
        break;
      case 6:
        context.pushNamed(recurringName);
        break;
      case 0:
        context.pushNamed(addTransactionsName);
        break;
      case 4:
        context.goNamed(addCategoryName);
        break;
      case 2:
        context.goNamed(addDebitName);
        break;
      case 3:
        _dateRangePicker(context);
        break;
      case 5:
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
        if (state is CurrentIndexState && state.currentPage != 5) {
          return SmallSizeFab(
            onPressed: () => _handleClick(context, state.currentPage),
            icon: state.currentPage != 3 ? Icons.add : Icons.date_range,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
