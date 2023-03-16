import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../main.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/accounts/model/account_model.dart';
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
        final accounts = value.values.toList();
        if (accounts.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addAccountPath),
            title: Text(
              context.loc.addAccountLabel,
            ),
            subtitle: Text(
              context.loc.noAccountAvailableLabel,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        return ScreenTypeLayout.builder(
          tablet: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectAccountLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
          mobile: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectAccountLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

  final List<AccountModel> accounts;
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
              if (index == 0) {
                return Hero(
                  tag: 'account',
                  child: ItemWidget(
                    isSelected: false,
                    title: 'Add New',
                    icon: MdiIcons.plus.codePoint,
                    onPressed: () => context.pushNamed(addAccountPath),
                  ),
                );
              }

              final account = accounts[index - 1];
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
