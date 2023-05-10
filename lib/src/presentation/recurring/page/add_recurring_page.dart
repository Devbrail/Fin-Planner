import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/transaction.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../../expense/widgets/expense_amount_widget.dart';
import '../../expense/widgets/expense_date_picker_widget.dart';
import '../../expense/widgets/expense_description_widget.dart';
import '../../expense/widgets/expense_name_widget.dart';
import '../../expense/widgets/expense_recurring_widget.dart';
import '../../expense/widgets/select_account_widget.dart';
import '../../expense/widgets/select_category_widget.dart';
import '../../widgets/paisa_big_button_widget.dart';

class AddRecurringPage extends StatefulWidget {
  const AddRecurringPage({super.key});

  @override
  State<AddRecurringPage> createState() => _AddRecurringPageState();
}

class _AddRecurringPageState extends State<AddRecurringPage> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  late final ExpenseBloc expenseBloc = getIt.get<ExpenseBloc>()
    ..add(const ChangeExpenseEvent(TransactionType.recurring));
  final nameController = TextEditingController();

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
          if (state is ExpenseSuccessState) {
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
          } else if (state is ExpenseAdded) {
            /* final content =
                expenseBloc.transactionType == TransactionType.expense
                    ? state.isAddOrUpdate
                        ? context.loc.addedExpense,
                        : context.loc.updatedExpense,
                    : state.isAddOrUpdate
                        ? context.loc.incomeAddedSuccessful,
                        : context.loc.incomeUpdateSuccessful

            context.showMaterialSnackBar(
              content,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ); */
            context.pop();
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: context.materialYouAppBar(
                context.loc.recurring,
              ),
              body: BlocBuilder(
                bloc: expenseBloc,
                buildWhen: (previous, current) =>
                    current is ChangeTransactionTypeState,
                builder: (context, state) {
                  return ListView(
                    shrinkWrap: true,
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
                      ExpenseRecurringWidget(
                        expenseBloc: expenseBloc,
                      ),
                      const SelectedAccount(),
                      const SelectCategoryIcon(),
                    ],
                  );
                },
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PaisaBigButton(
                    onPressed: () {
                      expenseBloc.add(const AddRecurringEvent());
                    },
                    title: context.loc.add,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
