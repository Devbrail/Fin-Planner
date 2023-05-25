import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/src/app/routes.dart';
import 'package:paisa/src/presentation/widgets/paisa_big_button_widget.dart';

import '../../../../core/common.dart';
import '../../../../domain/account/entities/account.dart';
import '../../../../domain/category/entities/category.dart';
import '../../../summary/widgets/expense_item_widget.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../bloc/accounts_bloc.dart';

class AccountTransactionPage extends StatelessWidget {
  const AccountTransactionPage({
    Key? key,
    required this.accountId,
  }) : super(key: key);

  final String accountId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccountsBloc>(context)
        .add(FetchAccountFromIdEvent(accountId));
    Account? account;
    return Scaffold(
      appBar: context.materialYouAppBar(
        context.loc.transactionHistory,
        actions: [
          IconButton(
            tooltip: context.loc.edit,
            onPressed: () {
              GoRouter.of(context).pushNamed(
                editAccountName,
                params: {'aid': accountId},
              );
            },
            icon: const Icon(Icons.edit_rounded),
          ),
          IconButton(
            tooltip: context.loc.delete,
            onPressed: () {
              BlocProvider.of<AccountsBloc>(context)
                  .add(DeleteAccountEvent(int.parse(accountId)));
            },
            icon: const Icon(Icons.delete_rounded),
          )
        ],
      ),
      body: BlocConsumer<AccountsBloc, AccountsState>(
        listener: (context, state) {
          if (state is AccountSuccessState) {
            account = state.account;
            BlocProvider.of<AccountsBloc>(context)
                .add(FetchExpensesFromAccountIdEvent(accountId));
          } else if (state is AccountDeletedState) {
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is ExpensesFromAccountIdState) {
            if (state.expenses.isEmpty) {
              return EmptyWidget(
                icon: Icons.credit_card,
                title: context.loc.noTransaction,
                description: context.loc.emptyAccountMessageSubTitle,
              );
            } else {
              if (account != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.expenses.length,
                  itemBuilder: (context, index) {
                    final Category category = BlocProvider.of<AccountsBloc>(
                            context)
                        .fetchCategoryFromId(state.expenses[index].categoryId)!
                        .toEntity();

                    return ExpenseItemWidget(
                      expense: state.expenses[index],
                      account: account!,
                      category: category,
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
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
                    queryParams: {'aid': accountId, 'type': '1'},
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
                    queryParams: {'aid': accountId, 'type': '0'},
                  );
                },
                title: context.loc.expense,
                iconData: Icons.add_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
