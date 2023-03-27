import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
            if (!kDebugMode) {
              final InAppReview inAppReview = InAppReview.instance;
              inAppReview
                  .isAvailable()
                  .then((value) => inAppReview.requestReview());
            }
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
              offset: state.expense.description.toString().length,
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
                shrinkWrap: true,
                children: [
                  TransactionToggleButtons(expenseBloc: expenseBloc),
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
                          const ExpenseDatePickerWidget(),
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
                            const ExpenseDatePickerWidget(),
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
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ExpenseBloc>(context),
      buildWhen: (oldState, newState) => newState is ChangeExpenseState,
      builder: (context, state) {
        if (state is ChangeExpenseState) {
          return PaisaTextFormField(
            maxLines: 1,
            controller: controller,
            hintText: state.transactionType.hintName(context),
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.singleLineFormatter,
            ],
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
}

class ExpenseDescriptionWidget extends StatelessWidget {
  const ExpenseDescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      maxLines: 1,
      controller: controller,
      hintText: context.loc.descriptionLabel,
      keyboardType: TextInputType.name,
      onChanged: (value) =>
          BlocProvider.of<ExpenseBloc>(context).currentDescription = value,
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
    return PaisaTextFormField(
      controller: controller,
      hintText: context.loc.amountLabel,
      keyboardType: TextInputType.number,
      maxLength: 13,
      maxLines: 1,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
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
}

class ExpenseDatePickerWidget extends StatefulWidget {
  const ExpenseDatePickerWidget({
    super.key,
  });

  @override
  State<ExpenseDatePickerWidget> createState() =>
      _ExpenseDatePickerWidgetState();
}

class _ExpenseDatePickerWidgetState extends State<ExpenseDatePickerWidget> {
  late final ExpenseBloc expenseBloc = BlocProvider.of<ExpenseBloc>(context);
  late DateTime selectedDateTime = expenseBloc.selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            horizontalTitleGap: 0,
            onTap: () async {
              final DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: selectedDateTime,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                selectedDateTime = selectedDateTime.copyWith(
                  day: dateTime.day,
                  month: dateTime.month,
                  year: dateTime.year,
                );
                expenseBloc.selectedDate = selectedDateTime;
                setState(() {});
              }
            },
            leading: const Icon(Icons.today_rounded),
            title: Text(selectedDateTime.formattedDate),
          ),
        ),
        Expanded(
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            horizontalTitleGap: 0,
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.dialOnly,
              );
              if (timeOfDay != null) {
                selectedDateTime = selectedDateTime.copyWith(
                  hour: timeOfDay.hour,
                  minute: timeOfDay.minute,
                );
                expenseBloc.selectedDate = selectedDateTime;
                setState(() {});
              }
            },
            leading: const Icon(MdiIcons.clockOutline),
            title: Text(selectedDateTime.formattedTime),
          ),
        ),
      ],
    );
  }
}
