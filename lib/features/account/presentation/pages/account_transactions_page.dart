import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/account/presentation/bloc/accounts_bloc.dart';
import 'package:paisa/features/home/domain/entity/combined_transaction_entity.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/transaction_widget.dart';
import 'package:paisa/features/home/presentation/controller/summary_controller.dart';

class AccountTransactionsPage extends StatelessWidget {
  const AccountTransactionsPage({
    Key? key,
    required this.accountId,
    required this.summaryController,
  }) : super(key: key);

  final String accountId;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    BlocProvider.of<AccountBloc>(context)
        .add(FetchAccountAndExpenseFromIdEvent(accountId));
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        appBar: context.materialYouAppBar(
          context.loc.transactionHistory,
          actions: <Widget>[
            IconButton(
              tooltip: context.loc.edit,
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  editAccountWithIdName,
                  pathParameters: {'aid': accountId},
                );
              },
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              tooltip: context.loc.delete,
              onPressed: () {
                paisaAlertDialog(
                  context,
                  title: Text(
                    context.loc.dialogDeleteTitle,
                  ),
                  child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (BuildContext context, AccountState state) {
                      if (state is AccountAndCombinedTransactionsState) {
                        return RichText(
                          text: TextSpan(
                            text: context.loc.deleteAccount,
                            style: context.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: state.account.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  confirmationButton: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {
                      BlocProvider.of<AccountBloc>(context)
                          .add(DeleteAccountEvent(accountId));
                      Navigator.pop(context);
                    },
                    child: Text(
                      context.loc.delete,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.delete_rounded),
            )
          ],
        ),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (BuildContext context, AccountState state) {
            if (state is AccountDeletedState) {
              context.pop();
            }
          },
          builder: (BuildContext context, AccountState state) {
            if (state is AccountAndCombinedTransactionsState) {
              if (state.expenses.isEmpty) {
                return EmptyWidget(
                  icon: Icons.credit_card,
                  title: context.loc.noTransaction,
                  description: context.loc.emptyAccountMessageSubTitle,
                );
              } else {
                return Scrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: state.expenses.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CombinedTransactionEntity expense =
                          state.expenses[index];

                      if (expense.category == null) {
                        return const SizedBox.shrink();
                      } else {
                        return TransactionWidget(
                          expense: expense,
                          account: state.account,
                          category: expense.category!,
                        );
                      }
                    },
                  ),
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PaisaIconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(
                      addTransactionsName,
                      queryParameters: {'aid': accountId, 'type': '1'},
                    );
                  },
                  title: context.loc.income,
                  iconData: Icons.add_rounded,
                ),
                const SizedBox(
                  width: 8,
                ),
                PaisaIconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(
                      addTransactionsName,
                      queryParameters: {'aid': accountId, 'type': '0'},
                    );
                  },
                  title: context.loc.expense,
                  iconData: Icons.add_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
