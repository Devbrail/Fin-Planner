import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/src/core/enum/card_type.dart';
import 'package:paisa/src/domain/category/entities/category.dart';
import 'package:paisa/src/presentation/accounts/widgets/account_card.dart';
import 'package:paisa/src/presentation/widgets/lava/lava_clock.dart';

import '../../../../../main.dart';
import '../../../../app/routes.dart';
import '../../../../core/common.dart';
import '../../../../core/theme/custom_color.dart';
import '../../../../data/category/data_sources/category_local_data_source.dart';
import '../../../summary/widgets/expense_item_widget.dart';
import '../../../widgets/paisa_bottom_sheet.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../bloc/accounts_bloc.dart';

class AccountTransactionPage extends StatelessWidget {
  AccountTransactionPage({
    Key? key,
    required this.accountId,
  }) : super(key: key);

  final String accountId;
  late final AccountsBloc accountsBloc = getIt.get()
    ..add(FetchAccountFromIdEvent(accountId));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: accountsBloc,
      builder: (context, state) {
        debugPrint(state.toString());
        if (state is AccountSuccessState) {
          final account = state.account;
          return Scaffold(
            appBar: AppBar(),
            body: Builder(
              builder: (context) {
                final expenses = accountsBloc
                    .fetchExpenseFromAccountId(int.parse(accountId));
                if (expenses.isEmpty) {
                  return EmptyWidget(
                    icon: Icons.credit_card,
                    title: context.loc.noTransactionLabel,
                    description: context.loc.errorNoCardsDescriptionLabel,
                  );
                } else {
                  return ListView(
                    children: [
                      LavaAnimation(
                        child: AccountCard(
                          cardNumber: account.number,
                          cardHolder: account.name,
                          bankName: account.name,
                          cardType: account.cardType ?? CardType.bank,
                          onTap: () => context.pushNamed(
                            'edit',
                            params: <String, String>{
                              'aid': account.superId!.toString()
                            },
                          ),
                          onDelete: () async => paisaAlertDialog<bool>(
                            context,
                            title: Text(context.loc.dialogDeleteTitleLabel),
                            child: RichText(
                              text: TextSpan(
                                text: context.loc.deleteAccountLabel,
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: account.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            confirmationButton: TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              onPressed: () {
                                accountsBloc.add(DeleteAccountEvent(account));
                                Navigator.pop(context, true);
                              },
                              child: Text(context.loc.deleteLabel),
                            ),
                          ).then(
                            (value) {
                              if (value != null && value) context.pop();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        title: Text(
                          context.loc.transactionHistoryLabel,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final Category category = accountsBloc
                              .fetchCategoryFromId(expenses[index].categoryId)!
                              .toEntity();
                          return ExpenseItemWidget(
                            expense: expenses[index],
                            account: account,
                            category: category,
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
