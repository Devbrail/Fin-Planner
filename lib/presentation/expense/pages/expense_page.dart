import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/util.dart';
import '../../../common/enum/transaction.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/select_account_widget.dart';
import '../widgets/select_category_widget.dart';
import '../widgets/toggle_buttons_widget.dart';

String formattedDate(DateTime? date) {
  if (date == null) {
    return '';
  }
  return DateFormat('dd/MM/yyyy').format(date);
}

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
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late ExpenseBloc expenseBloc = locator.get<ExpenseBloc>()
    ..add(FetchExpenseFromIdEvent(widget.expenseId));
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController dateTextController;
  late DateTime? selectedDate = DateTime.now();
  late int? selectedCategoryId;
  late int? selectedAccountId;
  late TransactonType selectedType;
  Expense? expense;

  bool get isAddExpense => widget.expenseId == null;

  void addExpense() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (isAddExpense) {
      expenseBloc.add(AddExpenseEvent(
        amount: amountController.text,
        name: nameController.text,
        time: selectedDate,
        categoryId: selectedCategoryId,
        accountId: selectedAccountId,
        type: selectedType,
      ));
    } else {
      expenseBloc.add(UpdateExpenseEvent(
        expense: expense,
        accountId: selectedAccountId,
        amount: amountController.text,
        categoryId: selectedCategoryId,
        name: nameController.text,
        time: selectedDate,
        type: selectedType,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => expenseBloc,
      child: BlocConsumer(
        bloc: expenseBloc,
        listener: (context, state) {
          if (state is ExpenseDeletedState) {
            showMaterialSnackBar(
              context,
              selectedType == TransactonType.expense
                  ? AppLocalizations.of(context)!.expenseDeletedSuccessfulLable
                  : AppLocalizations.of(context)!.incomeDeletedSuccessfulLable,
            );
            context.pop();
          } else if (state is ExpenseSuccessState) {
            final Expense e = state.expense;
          } else if (state is ExpenseAdded) {
            final content = selectedType == TransactonType.expense
                ? state.isAddOrUpdate
                    ? AppLocalizations.of(context)!.expenseAddedSuccessfulLable
                    : AppLocalizations.of(context)!.expenseUpdateSuccessfulLable
                : state.isAddOrUpdate
                    ? AppLocalizations.of(context)!.incomeAddedSuccessfulLable
                    : AppLocalizations.of(context)!.incomeUpdateSuccessfulLable;

            showMaterialSnackBar(context, content);
            context.pop();
          } else if (state is ExpenseErrorState) {
            showMaterialSnackBar(context, state.errorString);
          }
        },
        buildWhen: (previous, current) => current is ExpenseSuccessState,
        builder: (context, state) {
          if (state is ExpenseSuccessState) {
            expense = state.expense;
          }
          selectedDate = expense?.time;
          selectedCategoryId = expense?.categoryId;
          selectedAccountId = expense?.accountId;
          selectedType = expense?.type ?? TransactonType.expense;
          dateTextController =
              TextEditingController(text: formattedDate(selectedDate));
          nameController = TextEditingController(text: expense?.name);
          amountController = TextEditingController(
            text: expense?.currency.toString(),
          );
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: materialYouAppBar(
                context,
                isAddExpense
                    ? AppLocalizations.of(context)!.addExpenseLable
                    : AppLocalizations.of(context)!.updateExpenseLable,
                actions: [
                  isAddExpense
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () => expenseBloc
                              .add(ClearExpenseEvent(widget.expenseId!)),
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TransactionToggleButtons(
                      onSelected: (type) {
                        selectedType = type;
                        expenseBloc.add(ChangeExpenseEvent(type));
                      },
                      selectedType: selectedType,
                    ),
                    SelectCategoryIcon(
                      onSelected: (category) {
                        selectedCategoryId = category.key;
                      },
                    ),
                    SelectedAccount(
                      accountId: selectedAccountId ?? -1,
                      onSelected: (account) {
                        selectedAccountId = account.key;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpenseNameWidget(controller: nameController),
                            const SizedBox(height: 16),
                            ExpenseAmountWidget(controller: amountController),
                            const SizedBox(height: 16),
                            ExpenseDatePickerWidget(
                              controller: dateTextController,
                              selectedDate: selectedDate,
                              onSelectedDate: (date) {
                                selectedDate = date;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _addButton(),
                ),
              ),
            ),
            tablet: Scaffold(
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
                      ? AppLocalizations.of(context)!.addExpenseLable
                      : AppLocalizations.of(context)!.updateExpenseLable,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                actions: [
                  TransactionToggleButtons(
                    onSelected: (type) {
                      selectedType = type;
                      expenseBloc.add(ChangeExpenseEvent(type));
                    },
                    selectedType: selectedType,
                  ),
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
                        children: [
                          SelectCategoryIcon(
                            onSelected: (category) {
                              selectedCategoryId = category.key;
                            },
                          ),
                          const SizedBox(height: 24),
                          SelectedAccount(
                            accountId: selectedAccountId ?? -1,
                            onSelected: (account) {
                              selectedAccountId = account.key;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: _form,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpenseNameWidget(controller: nameController),
                            const SizedBox(height: 16),
                            ExpenseAmountWidget(controller: amountController),
                            const SizedBox(height: 16),
                            ExpenseDatePickerWidget(
                              controller: dateTextController,
                              selectedDate: selectedDate,
                              onSelectedDate: (date) {
                                selectedDate = date;
                              },
                            ),
                            const SizedBox(height: 16),
                            _addButton(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
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

  Widget _addButton() {
    return ElevatedButton(
      onPressed: addExpense,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(
        isAddExpense
            ? AppLocalizations.of(context)!.addLable
            : AppLocalizations.of(context)!.updateLable,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Theme.of(context).textTheme.headline6?.fontSize,
        ),
      ),
    );
  }
}

class ExpenseDatePickerWidget extends StatelessWidget {
  const ExpenseDatePickerWidget({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onSelectedDate,
  });

  final TextEditingController controller;
  final DateTime? selectedDate;
  final Function(DateTime) onSelectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            enabled: false,
            autocorrect: true,
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.dateLable,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              final dateString = formattedDate(date);
              controller.text = dateString;
              onSelectedDate.call(date);
            }
          },
          icon: const Icon(Icons.today_rounded),
        )
      ],
    );
  }
}

class ExpenseNameWidget extends StatelessWidget {
  const ExpenseNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ExpenseBloc>(context),
      buildWhen: (oldState, newState) => newState is ChangeExpenseState,
      builder: (context, state) {
        if (state is ChangeExpenseState) {
          return TextFormField(
            controller: controller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: state.transactionType == TransactonType.expense
                  ? AppLocalizations.of(context)!.expenseNameLable
                  : AppLocalizations.of(context)!.incomeNameLable,
            ),
            onChanged: (value) {},
            validator: (value) {
              if (value!.length >= 3) {
                return null;
              } else {
                return AppLocalizations.of(context)!.validNameLable;
              }
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class ExpenseAmountWidget extends StatelessWidget {
  const ExpenseAmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.amountLable,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
      ),
      maxLength: 13,
      validator: (value) {
        if (value!.length > 1) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validAmountLable;
        }
      },
    );
  }
}
