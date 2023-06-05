import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../main.dart';
import '../../../../app/routes.dart';
import '../../../../core/common.dart';
import '../../../../data/accounts/data_sources/default_account.dart';
import '../../../../data/accounts/data_sources/local_account_data_manager.dart';
import '../../../../data/accounts/model/account_model.dart';
import '../../../settings/bloc/settings_controller.dart';
import '../../../widgets/paisa_big_button_widget.dart';
import '../../../widgets/paisa_card.dart';

class AccountSelectorPage extends StatefulWidget {
  const AccountSelectorPage({super.key});

  @override
  State<AccountSelectorPage> createState() => _AccountSelectorPageState();
}

class _AccountSelectorPageState extends State<AccountSelectorPage> {
  final List<AccountModel> defaultModels = defaultAccountsData();
  final LocalAccountDataManager dataSource = getIt.get();
  final SettingsController settings = getIt.get<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(context.loc.accounts),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PaisaBigButton(
            onPressed: () async {
              context.go(currencySelectorPath);
              await settings.put(userAccountSelectorKey, false);
            },
            title: context.loc.done,
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<AccountModel>>(
        valueListenable: getIt.get<Box<AccountModel>>().listenable(),
        builder: (context, value, child) {
          final List<AccountModel> categoryModels = value.values.toList();
          return ListView(
            children: [
              ListTile(
                title: Text(
                  context.loc.addedAccounts,
                  style: GoogleFonts.outfit(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              PaisaFilledCard(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryModels.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final AccountModel model = categoryModels[index];
                    return ListTile(
                      onTap: () async {
                        await model.delete();
                        defaultModels.add(model);
                      },
                      leading: Icon(
                        model.cardType!.icon,
                        color:
                            Color(model.color ?? Colors.brown.shade200.value),
                      ),
                      title: Text(model.name),
                      subtitle: Text(model.bankName),
                      trailing: const Icon(MdiIcons.delete),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(
                  context.loc.defaultAccounts,
                  style: GoogleFonts.outfit(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: defaultModels
                      .map((model) => FilterChip(
                            onSelected: (value) {
                              dataSource.addAccount(model
                                ..name = settings.get(
                                  userNameKey,
                                  defaultValue: model.name,
                                ));
                              setState(() {
                                defaultModels.remove(model);
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            showCheckmark: false,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            label: Text(model.bankName),
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            padding: const EdgeInsets.all(12),
                            avatar: Icon(
                              model.cardType!.icon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
