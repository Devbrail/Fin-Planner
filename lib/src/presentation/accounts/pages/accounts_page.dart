import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../widgets/paisa_empty_widget.dart';
import 'horizontal/account_horizontal_page.dart';
import 'vertical/account_vertical_page.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('accounts_mobile'),
      body: ValueListenableBuilder<Box<dynamic>>(
        valueListenable: getIt
            .get<Box<dynamic>>(instanceName: BoxType.settings.name)
            .listenable(keys: [userAccountsStyleKey]),
        builder: (_, settings, __) {
          return ValueListenableBuilder<Box<AccountModel>>(
            valueListenable: getIt.get<Box<AccountModel>>().listenable(),
            builder: (_, value, __) {
              final List<Account> accounts = value.toEntities();
              if (accounts.isEmpty) {
                return EmptyWidget(
                  icon: Icons.credit_card,
                  title: context.loc.emptyAccountMessageTitle,
                  description: context.loc.emptyAccountMessageSubTitle,
                );
              }
              if (settings.get(userAccountsStyleKey, defaultValue: false)) {
                return AccountMobileHorizontalPage(accounts: accounts);
              } else {
                return AccountMobileVerticalPage(accounts: accounts);
              }
            },
          );
        },
      ),
    );
  }
}
