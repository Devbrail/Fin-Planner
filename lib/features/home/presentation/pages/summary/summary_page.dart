import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:paisa/features/home/presentation/cubit/combined_transaction/combined_transaction_cubit.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/summary_desktop_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/summary_mobile_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/summary_tablet_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final CombinedTransactionCubit cubit;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with AutomaticKeepAliveClientMixin {
  final List<CombinedTransactionEntity> transactions = [];
  @override
  void initState() {
    super.initState();
    widget.cubit.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder(
      bloc: widget.cubit,
      builder: (BuildContext context, CombinedTransactionState state) {
        if (state is CombinedResultState) {
          transactions.addAll(state.result);
        }
        return ScreenTypeLayout(
          mobile: SummaryMobileWidget(transactions: transactions),
          tablet: SummaryTabletWidget(expenses: transactions),
          desktop: SummaryDesktopWidget(transactions: transactions),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
