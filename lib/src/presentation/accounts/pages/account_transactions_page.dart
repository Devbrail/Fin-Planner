import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../app/routes.dart';
import '../../widgets/paisa_big_button_widget.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../summary/widgets/expense_item_widget.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';

class AccountTransactionsPage extends StatelessWidget {
  const AccountTransactionsPage({
    Key? key,
    required this.accountId,
  }) : super(key: key);

  final String accountId;

  @override
  Widget build(BuildContext context) {
    final SummaryController summaryController = getIt.get();
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
                child: RichText(
                  text: TextSpan(
                    text: context.loc.deleteAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: account?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                confirmationButton: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: () {
                    BlocProvider.of<AccountsBloc>(context)
                        .add(DeleteAccountEvent(int.parse(accountId)));
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
                    final Expense expense = state.expenses[index];
                    final Account? account =
                        summaryController.getAccount(expense.accountId);
                    final Category? category =
                        summaryController.getCategory(expense.categoryId);

                    if (account == null || category == null) {
                      return ExpenseItemWidget(
                        expense: expense,
                        account: account!,
                        category: Category(
                          icon: MdiIcons.bankTransfer.codePoint,
                          name: 'Transfer',
                          color: Colors.amber.value,
                        ),
                      );
                    } else {
                      return ExpenseItemWidget(
                        expense: expense,
                        account: account,
                        category: category,
                      );
                    }
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
    );
  }
}
