import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/core/common.dart';

import '../../../../main.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';

class PillsAccountWidget extends StatefulWidget {
  const PillsAccountWidget({
    super.key,
    required this.accountSelected,
    required this.selectedAccount,
  });

  final Function(Account) accountSelected;
  final int selectedAccount;

  @override
  State<PillsAccountWidget> createState() => _PillsAccountWidgetState();
}

class _PillsAccountWidgetState extends State<PillsAccountWidget> {
  late int selectedAccount = widget.selectedAccount;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<AccountModel>>(
      valueListenable: getIt.get<Box<AccountModel>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toEntities();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            children: List.generate(
              accounts.length,
              (index) {
                final Account account = accounts[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: account.superId == selectedAccount,
                    onSelected: (value) {
                      setState(() {
                        if (selectedAccount == account.superId) {
                          selectedAccount = -1;
                        } else {
                          selectedAccount = account.superId ?? -1;
                        }
                        widget.accountSelected(account);
                      });
                    },
                    avatar: Icon(
                      color: account.superId == selectedAccount
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      IconData(
                        account.icon,
                        fontFamily: 'Material Design Icons',
                        fontPackage: 'material_design_icons_flutter',
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    showCheckmark: false,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(account.bankName),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                            color: account.superId == selectedAccount
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant),
                    padding: const EdgeInsets.all(12),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
