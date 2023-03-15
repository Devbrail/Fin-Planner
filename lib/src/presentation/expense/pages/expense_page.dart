import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/transaction.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../../widgets/paisa_text_field.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/select_account_widget.dart';
import '../widgets/select_category_widget.dart';
import '../widgets/toggle_buttons_widget.dart';
import 'package:in_app_review/in_app_review.dart';

final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
  late final expenseBloc = getIt.get<ExpenseBloc>()
    ..add(const ChangeExpenseEvent(TransactionType.expense))
    ..add(FetchExpenseFromIdEvent(widget.expenseId));
  late TextEditingController nameController = TextEditingController();
  late TextEditingController amountController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController dateTextController = TextEditingController();

  bool get isAddExpense => widget.expenseId == null;

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    dateTextController.dispose();
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
                  ? context.loc.expenseDeletedSuccessfulLabel
                  : context.loc.incomeDeletedSuccessfulLabel,
              backgroundColor: Theme.of(context).colorScheme.error,
              color: Theme.of(context).colorScheme.onError,
            );
            context.pop();
          } else if (state is ExpenseAdded) {
            final content =
                expenseBloc.transactionType == TransactionType.expense
                    ? state.isAddOrUpdate
                        ? context.loc.expenseAddedSuccessfulLabel
                        : context.loc.expenseUpdateSuccessfulLabel
                    : state.isAddOrUpdate
                        ? context.loc.incomeAddedSuccessfulLabel
                        : context.loc.incomeUpdateSuccessfulLabel;

            context.showMaterialSnackBar(
              content,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            );
            final InAppReview inAppReview = InAppReview.instance;

            inAppReview
                .isAvailable()
                .then((value) => inAppReview.requestReview());
            context.pop();
          } else if (state is ExpenseErrorState) {
            context.showMaterialSnackBar(
              state.errorString,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              color: Theme.of(context).colorScheme.onErrorContainer,
            );
          } else if (state is ExpenseSuccessState) {
            if (expenseBloc.selectedDate != null) {
              dateTextController.text = expenseBloc.selectedDate!.formattedDate;
            }
            nameController.text = state.expense.name;
            nameController.selection = TextSelection.collapsed(
              offset: state.expense.name.length,
            );
            amountController.text = state.expense.currency.toString();
            amountController.selection = TextSelection.collapsed(
              offset: state.expense.currency.toString().length,
            );
            descriptionController.text = state.expense.description.toString();
            descriptionController.selection = TextSelection.collapsed(
              offset: state.expense.description.toString().length,
            );
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout.builder(
            mobile: (_) => Scaffold(
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
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
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
                children: [
                  TransactionToggleButtons(
                    onSelected: (type) {
                      expenseBloc.transactionType = type;
                      expenseBloc.add(ChangeExpenseEvent(type));
                    },
                    selectedType: expenseBloc.transactionType,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: _form,
                      child: Column(
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
                          ExpenseDatePickerWidget(
                            controller: dateTextController,
                            selectedDate: expenseBloc.selectedDate,
                            onSelectedDate: (date) {
                              expenseBloc.selectedDate = date;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  const SelectedAccount(),
                  const SelectCategoryIcon(),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _addButton(context),
                ),
              ),
            ),
            tablet: (_) => Scaffold(
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
                  TransactionToggleButtons(
                    onSelected: (type) {
                      expenseBloc.transactionType = type;
                      expenseBloc.add(ChangeExpenseEvent(type));
                    },
                    selectedType: expenseBloc.transactionType,
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
                        children: const [
                          SelectedAccount(),
                          SelectCategoryIcon(),
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
                            ExpenseDescriptionWidget(
                                controller: descriptionController),
                            const SizedBox(height: 16),
                            ExpenseAmountWidget(controller: amountController),
                            const SizedBox(height: 16),
                            ExpenseDatePickerWidget(
                              controller: dateTextController,
                              selectedDate: expenseBloc.selectedDate,
                              onSelectedDate: (date) {
                                expenseBloc.selectedDate = date;
                              },
                            ),
                            const SizedBox(height: 16),
                            _addButton(context),
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

  Widget _addButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final isValid = _form.currentState!.validate();
        if (!isValid) {
          return;
        }

        BlocProvider.of<ExpenseBloc>(context)
            .add(AddOrUpdateExpenseEvent(isAddExpense));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(
        isAddExpense ? context.loc.addLabel : context.loc.updateLabel,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
        ),
      ),
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
  Widget build(BuildContext context) => BlocBuilder(
        bloc: BlocProvider.of<ExpenseBloc>(context),
        buildWhen: (oldState, newState) => newState is ChangeExpenseState,
        builder: (context, state) {
          if (state is ChangeExpenseState) {
            return PaisaTextFormField(
              maxLines: 1,
              controller: controller,
              hintText: state.transactionType.hintName(context),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return context.loc.validNameLabel;
                }
              },
              onChanged: (value) =>
                  BlocProvider.of<ExpenseBloc>(context).expenseName = value,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}

class ExpenseDescriptionWidget extends StatelessWidget {
  const ExpenseDescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => PaisaTextFormField(
        maxLines: 1,
        controller: controller,
        hintText: context.loc.descriptionLabel,
        keyboardType: TextInputType.name,
        onChanged: (value) =>
            BlocProvider.of<ExpenseBloc>(context).currentDescription = value,
      );
}

class ExpenseAmountWidget extends StatelessWidget {
  const ExpenseAmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => PaisaTextFormField(
        controller: controller,
        hintText: context.loc.amountLabel,
        keyboardType: TextInputType.number,
        maxLength: 13,
        maxLines: 1,
        onChanged: (value) {
          double? amount = double.tryParse(value);
          BlocProvider.of<ExpenseBloc>(context).expenseAmount = amount;
        },
        validator: (value) {
          if (value!.isNotEmpty) {
            return null;
          } else {
            return context.loc.validAmountLabel;
          }
        },
      );
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
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PaisaTextFormField(
              enabled: false,
              controller: controller
                ..text = (selectedDate ?? DateTime.now()).formattedDate,
              keyboardType: TextInputType.number,
              hintText: 'Select date',
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
                final dateString = date.formattedDate;
                controller.text = dateString;
                onSelectedDate.call(date);
              }
            },
            icon: const Icon(Icons.today_rounded),
          )
        ],
      );
}
