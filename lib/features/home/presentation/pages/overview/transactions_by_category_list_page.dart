import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/home/presentation/cubit/combined_transaction/combined_transaction_cubit.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/transaction_widget.dart';

class TransactionByCategoryListPage extends StatelessWidget {
  const TransactionByCategoryListPage({
    super.key,
    required this.categoryId,
    required this.combinedTransactionCubit,
  });

  final String categoryId;
  final CombinedTransactionCubit combinedTransactionCubit;

  @override
  Widget build(BuildContext context) {
    final int cid = int.parse(categoryId);
    combinedTransactionCubit.fetchTransactionsByCategoryId(cid);
    return PaisaAnnotatedRegionWidget(
      color: Colors.transparent,
      child: BlocBuilder<CombinedTransactionCubit, CombinedTransactionState>(
        buildWhen: (previous, current) => current is ResultByCategoryIdState,
        builder: (context, state) {
          if (state is ResultByCategoryIdState) {
            final List<CombinedTransactionEntity> transactions = state.result;
            return Scaffold(
              extendBody: true,
              appBar:
                  context.materialYouAppBar(context.loc.transactionsByCategory),
              bottomNavigationBar: SafeArea(
                child: PaisaFilledCard(
                  child: ListTile(
                    title: Text(
                      context.loc.total,
                      style: context.titleSmall
                          ?.copyWith(color: context.onSurfaceVariant),
                    ),
                    subtitle: Text(
                      transactions.total.toFormateCurrency(context),
                      style: context.titleMedium?.copyWith(
                        color: context.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionWidget(
                    expense: transactions[index],
                    account: transactions[index].account,
                    category: transactions[index].category,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
