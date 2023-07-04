import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/core/common.dart';

import '../../../../main.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../widgets/paisa_card.dart';

class PillsAccountWidget extends StatefulWidget {
  const PillsAccountWidget({
    super.key,
    required this.accountSelected,
  });

  final Function(Account) accountSelected;

  @override
  State<PillsAccountWidget> createState() => _PillsAccountWidgetState();
}

class _PillsAccountWidgetState extends State<PillsAccountWidget> {
  late int selectedAccount = -1;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<AccountModel>>(
      valueListenable: getIt.get<Box<AccountModel>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toEntities();

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 16 / 5,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: accounts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final Account account = accounts[index];
            return PaisaFilterChip(
              color: Color(account.color ?? Colors.brown.shade200.value),
              onPressed: () {
                setState(() {
                  if (selectedAccount == account.superId) {
                    selectedAccount = -1;
                  } else {
                    selectedAccount = account.superId ?? -1;
                  }
                  widget.accountSelected(account);
                });
              },
              isSelected: account.superId == selectedAccount,
              icon: account.cardType!.icon,
              title: account.bankName,
            );
          },
        );
      },
    );
  }
}

class PaisaFilterChip extends StatelessWidget {
  const PaisaFilterChip({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PaisaFilledCard(
      color: color.withOpacity(0.09),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(
                  color: color,
                ),
                borderRadius: BorderRadius.circular(50),
              )
            : null,
        child: ListTile(
          onTap: onPressed,
          title: Text(
            title,
            style: context.titleSmall?.copyWith(color: color),
          ),
          leading: Icon(icon, color: color),
        ),
      ),
    );
  }
}
