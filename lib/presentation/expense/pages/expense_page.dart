import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/theme.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/transaction.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/expense/model/expense.dart';
import '../../../di/service_locator.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/select_account_widget.dart';
import '../widgets/select_category_widget.dart';
import '../widgets/toggle_buttons_widget.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense? expense;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _form = GlobalKey<FormState>();
  final expenseBloc = locator.get<ExpenseBloc>();

  late TextEditingController nameTextController;
  late TextEditingController amountTextController;
  late TextEditingController dateTextController;

  DateTime selectedDate = DateTime.now();
  int? selectedCategoryId;
  int? selectedAccountId;
  TransactonType selectedType = TransactonType.expense;
  String? errorMessage;
  bool get isAddExpense => widget.expense == null;

  Future<void> addExpense() async {
    if (selectedCategoryId == null) {
      errorMessage = 'Select category';
      setState(() {});
      return;
    }
    if (selectedAccountId == null) {
      errorMessage = 'Select account';
      setState(() {});
      return;
    }

    errorMessage = null;
    setState(() {});

    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (isAddExpense) {
      expenseBloc.add(
        AddExpenseEvent(
          amount: amountTextController.text,
          name: nameTextController.text,
          time: selectedDate,
          categoryId: selectedCategoryId!,
          accountId: selectedAccountId!,
          type: selectedType,
        ),
      );
    } else {
      final double amount = double.parse(amountTextController.text);
      widget.expense!
        ..accountId = selectedAccountId!
        ..categoryId = selectedCategoryId!
        ..currency = amount
        ..name = nameTextController.text
        ..time = selectedDate
        ..type = selectedType;
      await widget.expense!.save();
      expenseBloc.add(UpdateExpenseEvent(expense: widget.expense!));
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.expense != null) {
      nameTextController = TextEditingController(text: widget.expense!.name);
      amountTextController = TextEditingController(
        text: widget.expense!.currency.toString(),
      );
      selectedDate = widget.expense!.time;
      final dateString = formattedDate(selectedDate);
      dateTextController = TextEditingController(text: dateString);
      selectedCategoryId = widget.expense!.categoryId;
      selectedAccountId = widget.expense!.accountId;
      selectedType = widget.expense!.type ?? TransactonType.expense;
    } else {
      nameTextController = TextEditingController();
      amountTextController = TextEditingController();
      dateTextController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: expenseBloc,
      listener: (context, state) {
        if (state is ExpenseDeletedState) {
          showMaterialSnackBar(
            context,
            AppLocalizations.of(context)!.expenseDeletedSuccessful,
          );
        } else if (state is ExpenseAdded) {
          String content = '';
          if (state.isAddOrUpdate) {
            content = AppLocalizations.of(context)!.expenseAddedSuccessful;
          } else {
            content = AppLocalizations.of(context)!.expenseUpdateSuccessful;
          }
          showMaterialSnackBar(context, content);
        }
        Navigator.pop(context);
      },
      child: ScreenTypeLayout(
        mobile: Scaffold(
          appBar: materialYouAppBar(
            context,
            isAddExpense
                ? AppLocalizations.of(context)!.addExpense
                : AppLocalizations.of(context)!.updateExpense,
            actions: [
              isAddExpense
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () =>
                          expenseBloc.add(ClearExpenseEvent(widget.expense!)),
                      icon: const Icon(Icons.delete_rounded),
                    )
            ],
          ),
          body: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TransactionToggleButtons(
                    onSelected: (type) {
                      selectedType = type;
                    },
                  ),
                  SelectCategoryIcon(
                    onSelected: (category) {
                      selectedCategoryId = category.key;
                    },
                  ),
                  SelectedAccount(
                    onSelected: (account) {
                      selectedAccountId = account.key;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _expenseForm(),
                  ),
                ],
              ),
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
                  MediaQuery.of(context).platformBrightness == Brightness.dark
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
                  ? AppLocalizations.of(context)!.addExpense
                  : AppLocalizations.of(context)!.updateExpense,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            actions: [
              TransactionToggleButtons(
                onSelected: (type) {
                  selectedType = type;
                },
              ),
              isAddExpense
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        expenseBloc.add(ClearExpenseEvent(widget.expense!));
                      },
                      icon: const Icon(Icons.delete_rounded),
                    )
            ],
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 24,
                          left: 12,
                          right: 12,
                        ),
                        child: SelectCategoryIcon(
                          onSelected: (category) {
                            selectedCategoryId = category.key;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        child: SelectedAccount(
                          onSelected: (account) {
                            selectedAccountId = account.key;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        _expenseForm(),
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
      ),
    );
  }

  Widget _addButton() {
    return ElevatedButton(
      onPressed: addExpense,
      child: Text(
        isAddExpense
            ? AppLocalizations.of(context)!.add
            : AppLocalizations.of(context)!.update,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w700, color: context.onPrimary),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }

  Widget _expenseForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _expenseName(),
        const SizedBox(height: 16),
        _amountTextField(),
        const SizedBox(height: 16),
        _datePicker(),
        const SizedBox(height: 16),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(
              color: Colors.red,
            ),
          )
      ],
    );
  }

  Widget _datePicker() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: false,
            autocorrect: true,
            autofocus: true,
            controller: dateTextController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.date,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
            ),
            validator: (value) {
              if (value!.length > 1) {
                return null;
              } else {
                return AppLocalizations.of(context)!.validDate;
              }
            },
          ),
        ),
        IconButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              selectedDate = date;
              final dateString = formattedDate(date);
              dateTextController.text = dateString;
            }
          },
          icon: const Icon(
            Icons.today_rounded,
            size: 32,
          ),
        )
      ],
    );
  }

  Widget _amountTextField() {
    return TextFormField(
      autocorrect: true,
      autofocus: true,
      controller: amountTextController,
      keyboardType: TextInputType.number,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.amount,
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
          return AppLocalizations.of(context)!.validAmount;
        }
      },
    );
  }

  Widget _expenseName() {
    return TextFormField(
      autocorrect: true,
      autofocus: true,
      controller: nameTextController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.expenseName,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
      ),
      onChanged: (value) {},
      validator: (value) {
        if (value!.length >= 3) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validName;
        }
      },
    );
  }

  String formattedDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
}
