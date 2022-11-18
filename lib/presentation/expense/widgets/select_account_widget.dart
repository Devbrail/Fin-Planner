import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../data/accounts/model/account.dart';
import '../../../di/service_locator.dart';
import '../bloc/expense_bloc.dart';
import 'selectable_item_widget.dart';

class SelectedAccount extends StatelessWidget {
  const SelectedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    late final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    return ValueListenableBuilder<Box<Account>>(
      valueListenable: locator.get<Box<Account>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toList();
        if (accounts.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addAccountPath),
            title: Text(
              AppLocalizations.of(context)!.addAccountLabel,
            ),
            subtitle: Text(
              AppLocalizations.of(context)!.noAccountAvailableLabel,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        return ScreenTypeLayout(
          tablet: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.selectAccountLabel,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SelectedItem(
                accounts: accounts,
                expenseBloc: expenseBloc,
              )
            ],
          ),
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.selectAccountLabel,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SelectedItem(
                accounts: accounts,
                expenseBloc: expenseBloc,
              )
            ],
          ),
        );
      },
    );
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    Key? key,
    required this.accounts,
    required this.expenseBloc,
  }) : super(key: key);

  final List<Account> accounts;
  final ExpenseBloc expenseBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: expenseBloc,
      builder: (context, state) {
        return SizedBox(
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: accounts.length + 1,
            itemBuilder: (_, index) {
              if (index == accounts.length) {
                return ItemWidget(
                  isSelected: false,
                  title: 'Add New',
                  icon: MdiIcons.plus.codePoint,
                  onPressed: () => context.pushNamed(addCategoryPath),
                );
              }

              final account = accounts[index];
              return ItemWidget(
                isSelected: account.key == expenseBloc.selectedAccountId,
                title: account.name,
                icon: account.icon,
                onPressed: () => expenseBloc.add(ChangeAccountEvent(account)),
                subtitle: account.bankName,
              );
            },
          ),
        );
      },
    );
  }
}
