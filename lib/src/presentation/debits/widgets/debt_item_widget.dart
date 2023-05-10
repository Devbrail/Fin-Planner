import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';
import '../../../data/debt/models/transactions_model.dart';
import '../../../domain/debt/entities/transaction.dart';
import '../../widgets/paisa_card.dart';
import '../../widgets/paisa_text_field.dart';
import '../cubit/debts_cubit.dart';

class DebtItemWidget extends StatelessWidget {
  const DebtItemWidget({
    super.key,
    required this.debt,
  });
  final DebtModel debt;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TransactionsModel>>(
      valueListenable: getIt.get<Box<TransactionsModel>>().listenable(),
      builder: (context, value, child) {
        final List<Transaction> transactions =
            value.getTransactionsFromId(debt.superId ?? 0).toEntities();
        final double amount = transactions.fold<double>(
            0, (previousValue, element) => previousValue + element.amount);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PaisaFilledCard(
            child: InkWell(
              onTap: () => context.pushNamed(
                debtAddOrEditName,
                params: {'did': debt.superId.toString()},
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      debt.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    subtitle: Text(
                      debt.description,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.75),
                      ),
                    ),
                    trailing: Text(
                      (debt.amount - amount).toCurrency(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: amount / debt.amount,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '${debt.expiryDateTime.daysDifference.isNegative ? '0' : debt.expiryDateTime.daysDifference}  Days Left',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, right: 14),
                        child: TextButton.icon(
                          icon: Icon(
                            MdiIcons.cashClock,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          label: Text(
                            debt.debtType == DebtType.debt
                                ? context.loc.payDebt
                                : context.loc.payDebt,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            final controller = TextEditingController();
                            showModalBottomSheet(
                              context: context,
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width >= 700
                                        ? 700
                                        : double.infinity,
                              ),
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: SafeArea(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        horizontalTitleGap: 0,
                                        title: Text(
                                          context.loc.payDebt,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: PaisaTextFormField(
                                                controller: controller,
                                                hintText:
                                                    context.loc.enterAmount,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r"[0-9.]")),
                                                  TextInputFormatter
                                                      .withFunction(
                                                          (oldValue, newValue) {
                                                    try {
                                                      final text =
                                                          newValue.text;
                                                      if (text.isNotEmpty) {
                                                        double.parse(text);
                                                      }
                                                      return newValue;
                                                    } catch (e) {}
                                                    return oldValue;
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.date_range),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                          ),
                                          onPressed: () {
                                            final double amount =
                                                double.tryParse(
                                                        controller.text) ??
                                                    0;
                                            getIt.get<DebtsBloc>().add(
                                                  AddTransactionToDebtEvent(
                                                    debt,
                                                    amount,
                                                  ),
                                                );

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            context.loc.update,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
