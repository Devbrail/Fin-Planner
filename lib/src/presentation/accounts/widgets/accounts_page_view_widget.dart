import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';
import '../../../domain/account/entities/account.dart';
import '../../widgets/lava/lava_clock.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../bloc/accounts_bloc.dart';
import 'account_card.dart';

class AccountPageViewWidget extends StatefulWidget {
  const AccountPageViewWidget({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  final List<Account> accounts;

  @override
  State<AccountPageViewWidget> createState() => _AccountPageViewWidgetState();
}

class _AccountPageViewWidgetState extends State<AccountPageViewWidget> {
  final PageController _controller = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is AccountSelectedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LavaAnimation(
                child: SizedBox(
                  height: 246,
                  child: PageView.builder(
                    padEnds: true,
                    pageSnapping: true,
                    key: const Key('accounts_page_view'),
                    controller: _controller,
                    itemCount: widget.accounts.length,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                      BlocProvider.of<AccountsBloc>(context)
                          .add(AccountSelectedEvent(widget.accounts[index]));
                    },
                    itemBuilder: (_, index) {
                      final Account account = widget.accounts[index];
                      final String expense =
                          state.expenses.totalExpense.toFormateCurrency();
                      final String income =
                          state.expenses.totalIncome.toFormateCurrency();
                      final String totalBalance =
                          (state.expenses.fullTotal + account.initialAmount)
                              .toFormateCurrency();
                      return AccountCard(
                        key: ValueKey(account.hashCode),
                        expense: expense,
                        income: income,
                        totalBalance: totalBalance,
                        cardHolder: account.name,
                        bankName: account.bankName,
                        cardType: account.cardType ?? CardType.bank,
                        onDelete: () => paisaAlertDialog(
                          context,
                          title: Text(
                            context.loc.dialogDeleteTitle,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: context.loc.deleteAccount,
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
                              BlocProvider.of<AccountsBloc>(context)
                                  .add(DeleteAccountEvent(account.superId!));
                              Navigator.pop(context);
                            },
                            child: Text(
                              context.loc.delete,
                            ),
                          ),
                        ),
                        onTap: () => context.pushNamed(
                          editAccountName,
                          params: <String, String>{
                            'aid': account.superId.toString()
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPageIndicator(),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildPageIndicator() => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.accounts.length,
          (index) => GestureDetector(
            onTap: () => _controller.jumpToPage(index),
            child: _indicator(
              index == selectedIndex,
            ),
          ),
        ),
      );

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).disabledColor,
      ),
    );
  }
}
