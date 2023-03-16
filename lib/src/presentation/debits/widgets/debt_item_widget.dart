import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../main.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/debt_type.dart';
import '../../../data/debt/models/debt_model.dart';
import '../../../data/debt/models/transactions_model.dart';
import '../../widgets/paisa_card.dart';
import '../../widgets/paisa_text_field.dart';
import '../cubit/debts_cubit.dart';

class DebtItemWidget extends StatelessWidget {
  const DebtItemWidget({super.key, required this.debt});
  final DebtModel debt;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TransactionsModel>>(
      valueListenable: getIt.get<Box<TransactionsModel>>().listenable(),
      builder: (context, value, child) {
        final transactions = value.getTransactionsFromId(debt.superId);
        final double amount = transactions.fold<double>(
            0, (previousValue, element) => previousValue + element.amount);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PaisaFilledCard(
            child: InkWell(
              onTap: () => GoRouter.of(context).goNamed(
                debtAddOrEditPath,
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
                            '${debt.expiryDateTime.daysDifference} Days Left',
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
                                ? context.loc.payDebtLabel
                                : context.loc.payDebtLabel,
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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  context.loc.payDebtLabel,
                                ),
                                content: PaisaTextFormField(
                                  controller: controller,
                                  hintText: context.loc.enterAmountLabel,
                                  keyboardType: TextInputType.number,
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      final double amount =
                                          double.tryParse(controller.text) ?? 0;
                                      getIt.get<DebtsBloc>().add(
                                            AddTransactionToDebtEvent(
                                              debt,
                                              amount,
                                            ),
                                          );

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      context.loc.updateLabel,
                                    ),
                                  ),
                                ],
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
