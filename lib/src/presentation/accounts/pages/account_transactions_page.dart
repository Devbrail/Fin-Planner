import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../domain/category/entities/category.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/controller/summary_controller.dart';
import '../../summary/widgets/expense_item_widget.dart';
import '../../widgets/paisa_annotate_region_widget.dart';
import '../../widgets/paisa_big_button_widget.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../../widgets/paisa_empty_widget.dart';
import '../bloc/accounts_bloc.dart';

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
    BlocProvider.of<AccountsBloc>(context)
        .add(FetchAccountAndExpenseFromIdEvent(accountId));
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
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
                  child: BlocBuilder<AccountsBloc, AccountsState>(
                    builder: (context, state) {
                      if (state is AccountAndExpensesState) {
                        return RichText(
                          text: TextSpan(
                            text: context.loc.deleteAccount,
                            style: context.bodyMedium,
                            children: [
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
                      BlocProvider.of<AccountsBloc>(context)
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
        body: BlocConsumer<AccountsBloc, AccountsState>(
          listener: (context, state) {
            if (state is AccountDeletedState) {
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is AccountAndExpensesState) {
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
                    itemBuilder: (context, index) {
                      final Expense expense = state.expenses[index];
                      final Category? category = summaryController
                          .fetchCategoryFromId(expense.categoryId);
                      if (category == null) {
                        return const SizedBox.shrink();
                      } else {
                        return ExpenseItemWidget(
                          expense: expense,
                          account: state.account,
                          category: category,
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
