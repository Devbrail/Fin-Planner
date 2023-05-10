import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';
import '../bloc/expense_bloc.dart';
import 'selectable_item_widget.dart';

class SelectedAccount extends StatelessWidget {
  const SelectedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    late final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    return ValueListenableBuilder<Box<AccountModel>>(
      valueListenable: getIt.get<Box<AccountModel>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toEntities();
        if (accounts.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addAccountPath),
            title: Text(context.loc.addAccountEmptyTitle),
            subtitle: Text(context.loc.addAccountEmptySubTitle),
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
                  context.loc.selectAccount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              AccountSelectedItem(
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
                  context.loc.selectAccount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              AccountSelectedItem(
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

class AccountSelectedItem extends StatelessWidget {
  const AccountSelectedItem({
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
      buildWhen: (previous, current) => current is ChangeAccountState,
      builder: (context, state) {
        return SizedBox(
          height: 160,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemCount: accounts.length + 1,
            itemBuilder: (_, index) {
              if (index == 0) {
                return ItemWidget(
                  isSelected: false,
                  title: 'Add New',
                  icon: MdiIcons.plus.codePoint,
                  onPressed: () => context.pushNamed(addAccountPath),
                );
              } else {
                final Account account = accounts[index - 1];
                return ItemWidget(
                  isSelected: account.superId == expenseBloc.selectedAccountId,
                  title: account.name,
                  icon: account.icon,
                  onPressed: () => expenseBloc.add(ChangeAccountEvent(account)),
                  subtitle: account.bankName,
                );
              }
            },
          ),
        );
      },
    );
  }
}
