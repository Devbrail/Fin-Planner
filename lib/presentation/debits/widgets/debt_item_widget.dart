import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/enum/debt_type.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../common/constants/currency.dart';
import '../../widgets/paisa_card.dart';
import '../../widgets/paisa_text_field.dart';
import '../../../data/debt/models/debt.dart';
import '../../../data/debt/models/transaction.dart';
import '../../../di/service_locator.dart';
import '../cubit/debts_cubit.dart';

class DebtItemWidget extends StatelessWidget {
  const DebtItemWidget({super.key, required this.debt});
  final Debt debt;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Transaction>>(
      valueListenable: locator.get<Box<Transaction>>().listenable(),
      builder: (context, value, child) {
        final transactions = getTransactionsFromId(value.values, debt.superId);
        final double amount = transactions.fold<double>(
            0, (previousValue, element) => previousValue + element.amount);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PaisaCard(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: InkWell(
              onTap: () => GoRouter.of(context).goNamed(
                debitAddOrEditPath,
                params: {'did': debt.superId.toString()},
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LinearProgressIndicator(
                    value: amount / debt.amount,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  ListTile(
                    title: Text(
                      debt.name,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    subtitle: Text(
                      debt.description,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Text(
                      formattedCurrency(debt.amount - amount),
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutlinedButton.icon(
                      icon: Icon(
                        MdiIcons.cashClock,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      label: Text(
                        debt.debtType == DebtType.debt
                            ? AppLocalizations.of(context)!.payDebtLabel
                            : AppLocalizations.of(context)!.payDebtLabel,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                      ),
                      onPressed: () {
                        final controller = TextEditingController();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.payDebtLabel,
                            ),
                            content: PaisaTextFormField(
                              controller: controller,
                              hintText: AppLocalizations.of(context)!
                                  .enterAmountLabel,
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
                                  locator.get<DebtsBloc>().add(
                                      AddTransactionToDebtEvent(debt, amount));
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.updateLabel,
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
            ),
          ),
        );
      },
    );
  }
}

List<Transaction> getTransactionsFromId(Iterable<Transaction> debts, int? id) {
  if (id == null) return [];
  return debts.where((element) => element.parentId == id).toList();
}
