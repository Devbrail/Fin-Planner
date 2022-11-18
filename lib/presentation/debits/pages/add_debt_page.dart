import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/constants/context_extensions.dart';
import '../../../common/constants/currency.dart';
import '../../../common/enum/debt_type.dart';
import '../../../data/debt/models/transaction.dart';
import '../../../di/service_locator.dart';
import '../../expense/pages/expense_page.dart';
import '../../widgets/paisa_text_field.dart';
import '../cubit/debts_cubit.dart';
import '../widgets/debt_toggle_buttons_widget.dart';

class AddOrEditDebtPage extends StatefulWidget {
  const AddOrEditDebtPage({
    super.key,
    this.debtId,
  });
  final String? debtId;

  @override
  State<AddOrEditDebtPage> createState() => _AddOrEditDebtPageState();
}

class _AddOrEditDebtPageState extends State<AddOrEditDebtPage> {
  late final bool isUpdate = widget.debtId != null;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final DebtsBloc debtBloc = locator.get<DebtsBloc>()
    ..add(FetchDebtOrCreditFromIdEvent(widget.debtId))
    ..add(const ChangeDebtTypeEvent(DebtType.debt));
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => debtBloc,
      child: BlocConsumer(
        bloc: debtBloc,
        listener: (context, state) {
          if (state is DebtsAdded) {
            GoRouter.of(context).pop();
          } else if (state is DebtsSuccessState) {
            amountController.text = state.debt.amount.toString();
            amountController.selection = TextSelection.collapsed(
              offset: state.debt.amount.toString().length,
            );

            nameController.text = state.debt.name.toString();
            nameController.selection = TextSelection.collapsed(
              offset: state.debt.name.toString().length,
            );

            descController.text = state.debt.description.toString();
            descController.selection = TextSelection.collapsed(
              offset: state.debt.description.toString().length,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: context.materialYouAppBar(
              AppLocalizations.of(context)!.addDebtLabel,
              actions: [
                IconButton(
                  onPressed: () {
                    debtBloc.currentDebt
                        ?.delete()
                        .then((value) => context.pop());
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DebtToggleButtonsWidget(
                      onSelected: (p0) => debtBloc.currentDebtType = p0,
                      selectedType: debtBloc.currentDebtType,
                    ),
                    const SizedBox(height: 16),
                    AmountWidget(controller: amountController),
                    const SizedBox(height: 16),
                    NameWidget(controller: nameController),
                    const SizedBox(height: 16),
                    DescriptionWidget(controller: descController),
                    const SizedBox(height: 16),
                    DatePickerWidget(
                      onSelected: (date) => debtBloc.currentDateTime = date,
                      title: AppLocalizations.of(context)!.dateLabel,
                      subtitle: AppLocalizations.of(context)!.validDateLabel,
                      icon: MdiIcons.calendarStart,
                      lastDate: DateTime.now(),
                      firstDate: DateTime(2000),
                    ),
                    DatePickerWidget(
                      onSelected: (date) => debtBloc.currentDueDateTime = date,
                      title: AppLocalizations.of(context)!.dueDateLabel,
                      subtitle: AppLocalizations.of(context)!.validDateLabel,
                      icon: MdiIcons.calendarEnd,
                      lastDate: DateTime(2050),
                      firstDate: DateTime.now(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        AppLocalizations.of(context)!.transactionHistoryLabel,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ValueListenableBuilder<Box<Transaction>>(
                      valueListenable:
                          locator.get<Box<Transaction>>().listenable(),
                      builder: (context, value, child) {
                        final result = value.values
                            .where((element) =>
                                element.parentId ==
                                (int.tryParse(widget.debtId ?? '') ?? -1))
                            .toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: result.length,
                          itemBuilder: (_, index) {
                            final transaction = result[index];
                            return ListTile(
                              trailing:
                                  Text(formattedCurrency(transaction.amount)),
                              title: Text(
                                formattedDate(transaction.now),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    debtBloc.add(AddOrUpdateEvent(isUpdate));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.addLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                    ),
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

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
    required this.onSelected,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.lastDate,
    required this.firstDate,
  });
  final Function(DateTime) onSelected;
  final String title;
  final String subtitle;
  final IconData icon;
  final DateTime lastDate;
  final DateTime firstDate;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late String subtitle = widget.subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final result = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
        if (result == null) return;
        widget.onSelected.call(result);
        setState(() {
          subtitle = formattedDate(result);
        });
      },
      leading: Icon(widget.icon),
      title: Text(widget.title),
      subtitle: Text(subtitle),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      hintText: AppLocalizations.of(context)!.nameLabel,
      validator: (value) {
        if (value!.length >= 2) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validNameLabel;
        }
      },
      onChanged: (value) =>
          BlocProvider.of<DebtsBloc>(context).currentName = value,
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      hintText: AppLocalizations.of(context)!.descriptionLabel,
      validator: (value) {
        if (value!.length >= 3) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validDescriptionLabel;
        }
      },
      onChanged: (value) =>
          BlocProvider.of<DebtsBloc>(context).currentDescription = value,
    );
  }
}

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      hintText: AppLocalizations.of(context)!.amountLabel,
      onChanged: (value) {
        double? amount = double.tryParse(value);
        BlocProvider.of<DebtsBloc>(context).currentAmount = amount;
      },
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validAmountLabel;
        }
      },
    );
  }
}
