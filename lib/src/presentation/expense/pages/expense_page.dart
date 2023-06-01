import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction_type.dart';
import '../../widgets/paisa_annotate_region_widget.dart';
import '../../widgets/paisa_big_button_widget.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/expense_amount_widget.dart';
import '../widgets/expense_date_picker_widget.dart';
import '../widgets/expense_description_widget.dart';
import '../widgets/expense_name_widget.dart';
import '../widgets/pill_accounts_widget.dart';
import '../widgets/select_account_widget.dart';
import '../widgets/select_category_widget.dart';
import '../widgets/transaction_toggle_buttons_widget.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({
    Key? key,
    this.expenseId,
    this.transactionType,
    this.accountId,
    this.categoryId,
  }) : super(key: key);

  final String? expenseId;
  final String? accountId;
  final String? categoryId;
  final TransactionType? transactionType;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late final bool isAddExpense = widget.expenseId == null;
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseBloc>(context)
      ..add(
          ChangeExpenseEvent(widget.transactionType ?? TransactionType.expense))
      ..add(FetchExpenseFromIdEvent(widget.expenseId));
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: Theme.of(context).colorScheme.background,
      child: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseDeletedState) {
            context.showMaterialSnackBar(
              context.loc.deletedTransaction,
              backgroundColor: Theme.of(context).colorScheme.error,
              color: Theme.of(context).colorScheme.onError,
            );
            context.pop();
          } else if (state is ExpenseAdded) {
            final content = state.isAddOrUpdate
                ? context.loc.addedTransaction
                : context.loc.updatedTransaction;
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
          if (widget.accountId != null) {
            BlocProvider.of<ExpenseBloc>(context).selectedAccountId =
                int.tryParse(widget.accountId!);
          }
          if (widget.categoryId != null) {
            BlocProvider.of<ExpenseBloc>(context).selectedCategoryId =
                int.tryParse(widget.categoryId!);
          }
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: context.materialYouAppBar(
                isAddExpense
                    ? context.loc.addTransaction
                    : context.loc.updateTransaction,
                actions: [
                  isAddExpense
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () => paisaAlertDialog(
                            context,
                            title: Text(context.loc.dialogDeleteTitle),
                            child: RichText(
                              text: TextSpan(
                                text: context.loc.deleteExpense,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            confirmationButton: TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              onPressed: () {
                                BlocProvider.of<ExpenseBloc>(context)
                                    .add(ClearExpenseEvent(widget.expenseId!));
                                Navigator.pop(context);
                              },
                              child: Text(context.loc.delete),
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
                  const TransactionToggleButtons(),
                  const SizedBox(height: 16),
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    buildWhen: (previous, current) =>
                        current is ChangeTransactionTypeState,
                    builder: (context, state) {
                      if (state is ChangeTransactionTypeState &&
                          (state.transactionType == TransactionType.expense ||
                              state.transactionType ==
                                  TransactionType.income)) {
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: ExpenseDatePickerWidget(),
                            ),
                            const SelectedAccount(),
                            const SelectCategoryIcon(),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpenseAmountWidget(controller: amountController),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                context.loc.fromAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            PillsAccountWidget(
                              accountSelected: (account) {
                                BlocProvider.of<ExpenseBloc>(context)
                                    .fromAccount = account;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                context.loc.toAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            PillsAccountWidget(
                              accountSelected: (account) {
                                BlocProvider.of<ExpenseBloc>(context)
                                    .toAccount = account;
                              },
                            ),
                            const SizedBox(height: 16),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: ExpenseDatePickerWidget(),
                            ),
                          ],
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
                      BlocProvider.of<ExpenseBloc>(context)
                          .add(AddOrUpdateExpenseEvent(isAddExpense));
                    },
                    title: isAddExpense ? context.loc.add : context.loc.update,
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
                      BlocProvider.of<ExpenseBloc>(context)
                          .add(AddOrUpdateExpenseEvent(isAddExpense));
                    },
                    title: isAddExpense ? context.loc.add : context.loc.update,
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
                      ? context.loc.addTransaction
                      : context.loc.updateTransaction,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                actions: [
                  const TransactionToggleButtons(),
                  isAddExpense
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            BlocProvider.of<ExpenseBloc>(context)
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ExpenseNameWidget(controller: nameController),
                              const SizedBox(height: 16),
                              ExpenseDescriptionWidget(
                                  controller: descriptionController),
                              const SizedBox(height: 16),
                              ExpenseAmountWidget(controller: amountController),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: ExpenseDatePickerWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectedAccount(),
                        SelectCategoryIcon(),
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
