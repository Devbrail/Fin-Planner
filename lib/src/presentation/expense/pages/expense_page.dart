import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/transaction.dart';
import '../../../domain/account/entities/account.dart';
import '../../widgets/paisa_big_button_widget.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/expense_amount_widget.dart';
import '../widgets/expense_date_picker_widget.dart';
import '../widgets/expense_description_widget.dart';
import '../widgets/expense_name_widget.dart';
import '../widgets/expense_recurring_widget.dart';
import '../widgets/select_account_widget.dart';
import '../widgets/select_category_widget.dart';
import '../widgets/selectable_item_widget.dart';
import '../widgets/toggle_buttons_widget.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({
    Key? key,
    this.expenseId,
  }) : super(key: key);

  final String? expenseId;
  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late final bool isAddExpense = widget.expenseId == null;
  late final ExpenseBloc expenseBloc = getIt.get<ExpenseBloc>()
    ..add(const ChangeExpenseEvent(TransactionType.expense))
    ..add(FetchExpenseFromIdEvent(widget.expenseId));
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => expenseBloc,
      child: BlocConsumer(
        bloc: expenseBloc,
        listener: (context, state) {
          if (state is ExpenseDeletedState) {
            context.showMaterialSnackBar(
              expenseBloc.transactionType == TransactionType.expense
                  ? context.loc.deletedExpenseLabel
                  : context.loc.incomeDeletedSuccessfulLabel,
              backgroundColor: Theme.of(context).colorScheme.error,
              color: Theme.of(context).colorScheme.onError,
            );
            context.pop();
          } else if (state is ExpenseAdded) {
            final content =
                expenseBloc.transactionType == TransactionType.expense
                    ? state.isAddOrUpdate
                        ? context.loc.addedExpenseLabel
                        : context.loc.updatedExpenseLabel
                    : state.isAddOrUpdate
                        ? context.loc.incomeAddedSuccessfulLabel
                        : context.loc.incomeUpdateSuccessfulLabel;

            context.showMaterialSnackBar(
              content,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            );
            context.pop();
          } else if (state is ExpenseErrorState) {
            context.showMaterialSnackBar(
              state.errorString,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              color: Theme.of(context).colorScheme.onErrorContainer,
            );
          } else if (state is ExpenseSuccessState) {
            nameController.text = state.expense.name;
            nameController.selection = TextSelection.collapsed(
              offset: state.expense.name.length,
            );
            amountController.text = state.expense.currency.toString();
            amountController.selection = TextSelection.collapsed(
              offset: state.expense.currency.toString().length,
            );
            descriptionController.text = state.expense.description ?? '';
            descriptionController.selection = TextSelection.collapsed(
              offset: state.expense.description?.length ?? 0,
            );
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: context.materialYouAppBar(
                isAddExpense
                    ? context.loc.addExpenseLabel
                    : context.loc.updateExpenseLabel,
                actions: [
                  isAddExpense
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () => paisaAlertDialog(
                            context,
                            title: Text(context.loc.dialogDeleteTitleLabel),
                            child: RichText(
                              text: TextSpan(
                                text: context.loc.deleteExpenseLabel,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            confirmationButton: TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              onPressed: () {
                                expenseBloc
                                    .add(ClearExpenseEvent(widget.expenseId!));
                                Navigator.pop(context);
                              },
                              child: Text(context.loc.deleteLabel),
                            ),
                          ),
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                ],
              ),
              body: ListView(
                shrinkWrap: true,
                children: [
                  TransactionToggleButtons(expenseBloc: expenseBloc),
                  const SizedBox(height: 16),
                  BlocBuilder(
                    bloc: expenseBloc,
                    buildWhen: (previous, current) =>
                        current is ChangeTransactionTypeState,
                    builder: (context, state) {
                      if (state is ChangeTransactionTypeState &&
                          (state.transactionType == TransactionType.expense ||
                              state.transactionType == TransactionType.income ||
                              state.transactionType ==
                                  TransactionType.recurring)) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpenseNameWidget(controller: nameController),
                            const SizedBox(height: 16),
                            ExpenseDescriptionWidget(
                              controller: descriptionController,
                            ),
                            const SizedBox(height: 16),
                            ExpenseAmountWidget(controller: amountController),
                            const SizedBox(height: 16),
                            const ExpenseDatePickerWidget(),
                            Visibility(
                              visible: state.transactionType ==
                                  TransactionType.recurring,
                              child: ExpenseRecurringWidget(
                                expenseBloc: expenseBloc,
                              ),
                            ),
                            const SelectedAccount(),
                            const SelectCategoryIcon(),
                          ],
                        );
                      } else {
                        return BlocBuilder(
                          bloc: expenseBloc,
                          buildWhen: (previous, current) =>
                              current is TransferAccountsState,
                          builder: (context, state) {
                            if (state is TransferAccountsState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'From Account',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                        left: 16,
                                        right: 16,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: state.accounts.length,
                                      itemBuilder: (_, index) {
                                        final Account account =
                                            state.accounts[index];
                                        return ItemWidget(
                                          isSelected: account.superId ==
                                              state.fromAccount.superId,
                                          title: account.name,
                                          icon: account.icon,
                                          onPressed: () {
                                            expenseBloc.add(
                                              TransferAccountsEvent(
                                                state.accounts,
                                                account,
                                                state.toAccount,
                                              ),
                                            );
                                          },
                                          subtitle: account.bankName,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'To Account',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                        left: 16,
                                        right: 16,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: state.accounts.length,
                                      itemBuilder: (_, index) {
                                        final Account account =
                                            state.accounts[index];
                                        return ItemWidget(
                                          isSelected: account.superId ==
                                              state.toAccount.superId,
                                          title: account.name,
                                          icon: account.icon,
                                          onPressed: () {
                                            expenseBloc.add(
                                              TransferAccountsEvent(
                                                state.accounts,
                                                state.fromAccount,
                                                account,
                                              ),
                                            );
                                          },
                                          subtitle: account.bankName,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ExpenseAmountWidget(
                                      controller: amountController,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PaisaBigButton(
                    onPressed: () {
                      expenseBloc.add(AddOrUpdateExpenseEvent(isAddExpense));
                    },
                    title: isAddExpense
                        ? context.loc.addLabel
                        : context.loc.updateLabel,
                  ),
                ),
              ),
            ),
            tablet: Scaffold(
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PaisaBigButton(
                    onPressed: () {
                      expenseBloc.add(AddOrUpdateExpenseEvent(isAddExpense));
                    },
                    title: isAddExpense
                        ? context.loc.addLabel
                        : context.loc.updateLabel,
                  ),
                ),
              ),
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                  statusBarIconBrightness:
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? Brightness.light
                          : Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  isAddExpense
                      ? context.loc.addExpenseLabel
                      : context.loc.updateExpenseLabel,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                actions: [
                  TransactionToggleButtons(expenseBloc: expenseBloc),
                  isAddExpense
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            expenseBloc
                                .add(ClearExpenseEvent(widget.expenseId!));
                          },
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                ],
              ),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          SelectedAccount(),
                          SelectCategoryIcon(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ExpenseNameWidget(controller: nameController),
                              const SizedBox(height: 16),
                              ExpenseDescriptionWidget(
                                  controller: descriptionController),
                              const SizedBox(height: 16),
                              ExpenseAmountWidget(controller: amountController),
                            ],
                          ),
                        ),
                        const ExpenseDatePickerWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
