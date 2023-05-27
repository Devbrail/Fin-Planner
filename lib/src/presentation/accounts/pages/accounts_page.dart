import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../settings/bloc/settings_controller.dart';
import '../../widgets/paisa_empty_widget.dart';
import 'horizontal/account_mobile_horizontal_page.dart';
import 'vertical/account_mobile_vertical_page.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = getIt.get();
    return Scaffold(
      key: const Key('accounts_mobile'),
      body: ValueListenableBuilder<Box<AccountModel>>(
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
          if (settingsController.get(userAccountsStyleKey,
              defaultValue: false)) {
            return AccountMobileHorizontalPage(accounts: accounts);
          } else {
            return AccountMobileVerticalPage(accounts: accounts);
          }
        },
      ),
    );
  }
}
