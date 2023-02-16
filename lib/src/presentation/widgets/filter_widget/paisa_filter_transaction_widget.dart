import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/common.dart';
import '../../../core/enum/filter_budget.dart';
import '../../home/bloc/home_bloc.dart';
import 'filter_budget_widget.dart';

final ValueNotifier<FilterBudget> valueNotifier =
    ValueNotifier<FilterBudget>(FilterBudget.daily);

class PaisaFilterTransactionWidget extends StatelessWidget {
  const PaisaFilterTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (context, state) {
          if (state is CurrentIndexState &&
              state.currentPage == PageType.budgetOverview) {
            return IconButton(
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
                  builder: (context) => FilterBudgetToggleWidget(
                    valueNotifier: valueNotifier,
                    showAsList: true,
                  ),
                );
              },
              icon: const Icon(MdiIcons.filter),
            );
          }
          return const SizedBox.shrink();
        },
      );
}
