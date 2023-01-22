import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/src/lava/lava_clock.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/context_extensions.dart';
import '../../../../core/enum/card_type.dart';
import '../../../../service_locator.dart';
import '../../../widgets/future_resolve.dart';
import '../../../widgets/multi_value_listenable_builder.dart';
import '../../../widgets/paisa_text_field.dart';
import '../../bloc/accounts_bloc.dart';
import '../../widgets/account_card.dart';
import '../../widgets/card_type_drop_down.dart';

final GlobalKey<FormState> _form = GlobalKey<FormState>();

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({
    Key? key,
    this.accountId,
  }) : super(key: key);

  final String? accountId;

  @override
  AddAccountPageState createState() => AddAccountPageState();
}

class AddAccountPageState extends State<AddAccountPage> {
  final ValueNotifier<String> accountNameNotifier = ValueNotifier('');
  final ValueNotifier<String> accountNumberNotifier = ValueNotifier('');
  final ValueNotifier<String> accountHolderNotifier = ValueNotifier('');

  final accountNumberController = TextEditingController();
  final accountHolderController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountInitialAmountController = TextEditingController();

  bool get isAccountAddOrUpdate => widget.accountId == null;

  @override
  void dispose() {
    accountHolderController.dispose();
    accountInitialAmountController.dispose();
    accountNumberController.dispose();
    accountNameController.dispose();
    accountNameNotifier.dispose();
    accountNumberNotifier.dispose();
    accountHolderNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureResolve<AccountsBloc>(
      future: locator.getAsync<AccountsBloc>(),
      builder: (value) {
        final AccountsBloc accountsBloc = value
          ..add(FetchAccountFromIdEvent(widget.accountId));
        return BlocProvider(
          create: (context) => accountsBloc,
          child: BlocConsumer(
            bloc: accountsBloc,
            listener: (context, state) {
              if (state is AddAccountState) {
                context.showMaterialSnackBar(
                  isAccountAddOrUpdate
                      ? AppLocalizations.of(context)!.addedCardLabel
                      : AppLocalizations.of(context)!.updatedCardLabel,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                );
                context.pop();
              }
              if (state is AccountDeletedState) {
                context.showMaterialSnackBar(
                  AppLocalizations.of(context)!.deletedCardLabel,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  color: Theme.of(context).colorScheme.onError,
                );
                context.pop();
              } else if (state is AccountErrorState) {
                context.showMaterialSnackBar(
                  state.errorString,
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                );
              } else if (state is AccountSuccessState) {
                accountNameNotifier.value = state.account.bankName;
                accountNameController.text = state.account.bankName;
                accountNameController.selection = TextSelection.collapsed(
                    offset: state.account.bankName.length);

                accountNumberNotifier.value = state.account.number;
                accountNumberController.text = state.account.number;
                accountNumberController.selection = TextSelection.collapsed(
                    offset: state.account.number.length);

                accountHolderNotifier.value = state.account.name;
                accountHolderController.text = state.account.name;
                accountHolderController.selection =
                    TextSelection.collapsed(offset: state.account.name.length);

                accountInitialAmountController.text =
                    state.account.amount.toString();
                accountInitialAmountController.selection =
                    TextSelection.collapsed(
                        offset: state.account.amount.toString().length);
              } /* else if (state is UpdateCardTypeState) {
                accountsBloc.selectedType = state.cardType;
              } */
            },
            builder: (context, state) {
              return ScreenTypeLayout(
                mobile: Scaffold(
                  appBar: context.materialYouAppBar(
                    isAccountAddOrUpdate
                        ? AppLocalizations.of(context)!.addCardLabel
                        : AppLocalizations.of(context)!.updateCardLabel,
                    actions: [
                      isAccountAddOrUpdate
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () => accountsBloc
                                  .add(ClearAccountEvent(widget.accountId!)),
                              icon: Icon(
                                Icons.delete_rounded,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                      IconButton(
                        onPressed: _showInfo,
                        icon: const Icon(Icons.info_rounded),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: CardTypeButtons(
                            onSelected: (cardType) {
                              accountsBloc.selectedType = cardType;
                              accountsBloc.add(UpdateCardTypeEvent(cardType));
                            },
                            selectedCardType: accountsBloc.selectedType,
                          ),
                        ),
                        MultiValueListenableBuilder(
                          valueListenables: [
                            accountNameNotifier,
                            accountHolderNotifier,
                            accountNumberNotifier,
                          ],
                          builder: (context, values, child) {
                            return LavaAnimation(
                              child: AccountCard(
                                cardNumber: values.elementAt(2),
                                cardHolder: values.elementAt(1),
                                bankName: values.elementAt(0),
                                cardType: accountsBloc.selectedType,
                              ),
                            );
                          },
                        ),
                        Form(
                          key: _form,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16),
                                AccountCardHolderNameWidget(
                                  controller: accountHolderController,
                                  accountBloc: accountsBloc,
                                  valueNotifier: accountHolderNotifier,
                                ),
                                const SizedBox(height: 16),
                                AccountNameWidget(
                                  controller: accountNameController,
                                  accountBloc: accountsBloc,
                                  valueNotifier: accountNameNotifier,
                                ),
                                const SizedBox(height: 16),
                                Builder(
                                  builder: (context) {
                                    if (state is UpdateCardTypeState &&
                                        (state.cardType == CardType.bank ||
                                            state.cardType ==
                                                CardType.wallet)) {
                                      return AccountInitialAmountWidget(
                                        controller:
                                            accountInitialAmountController,
                                        accountBloc: accountsBloc,
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                Builder(
                                  builder: (context) {
                                    if (state is UpdateCardTypeState &&
                                        state.cardType == CardType.bank) {
                                      return AccountNumberWidget(
                                        controller: accountNumberController,
                                        accountBloc: accountsBloc,
                                        valueNotifier: accountNumberNotifier,
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  bottomNavigationBar: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final isValid = _form.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          accountsBloc.add(
                              AddOrUpdateAccountEvent(isAccountAddOrUpdate));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          isAccountAddOrUpdate
                              ? AppLocalizations.of(context)!.addCardLabel
                              : AppLocalizations.of(context)!.updateLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:
                                Theme.of(context).textTheme.headline6?.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                tablet: Scaffold(
                  appBar: context.materialYouAppBar(
                    AppLocalizations.of(context)!.addCardLabel,
                    actions: [
                      IconButton(
                        onPressed: _showInfo,
                        icon: const Icon(Icons.info_rounded),
                      ),
                      isAccountAddOrUpdate
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () => accountsBloc
                                  .add(ClearAccountEvent(widget.accountId!)),
                              icon: Icon(
                                Icons.delete_rounded,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AccountCard(
                            cardNumber: accountNumberController.value.text,
                            cardHolder: accountHolderController.value.text,
                            bankName: accountNameController.value.text,
                            cardType: accountsBloc.selectedType,
                          ),
                        ),
                        Expanded(
                          child: Form(
                            key: _form,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CardTypeButtons(
                                    onSelected: (cardType) {
                                      accountsBloc.selectedType = cardType;
                                    },
                                    selectedCardType: accountsBloc.selectedType,
                                  ),
                                  const SizedBox(height: 16),
                                  AccountCardHolderNameWidget(
                                    controller: accountHolderController,
                                    accountBloc: accountsBloc,
                                    valueNotifier: accountHolderNotifier,
                                  ),
                                  const SizedBox(height: 16),
                                  AccountNameWidget(
                                    controller: accountNameController,
                                    accountBloc: accountsBloc,
                                    valueNotifier: accountNameNotifier,
                                  ),
                                  const SizedBox(height: 16),
                                  AccountInitialAmountWidget(
                                    controller: accountInitialAmountController,
                                    accountBloc: accountsBloc,
                                  ),
                                  const SizedBox(height: 16),
                                  AccountNumberWidget(
                                    controller: accountNumberController,
                                    accountBloc: accountsBloc,
                                    valueNotifier: accountNumberNotifier,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      final isValid =
                                          _form.currentState!.validate();
                                      if (!isValid) {
                                        return;
                                      }
                                      accountsBloc.add(AddOrUpdateAccountEvent(
                                          isAccountAddOrUpdate));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .addCardLabel,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.fontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showInfo() => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (context) {
          return SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(Icons.info_rounded),
                  title: Text(
                    AppLocalizations.of(context)!.accountInfoLabel,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context)!.accountInfoDescLabel,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.acceptLabel,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          );
        },
      );
}

class AccountCardHolderNameWidget extends StatelessWidget {
  const AccountCardHolderNameWidget({
    super.key,
    required this.controller,
    required this.accountBloc,
    required this.valueNotifier,
  });
  final TextEditingController controller;
  final AccountsBloc accountBloc;
  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PaisaTextFormField(
          controller: controller,
          label: AppLocalizations.of(context)!.cardHolderLabel,
          hintText: AppLocalizations.of(context)!.enterCardHolderNameLabel,
          keyboardType: TextInputType.name,
          onChanged: (value) {
            valueNotifier.value = value;
            accountBloc.accountHolderName = value;
          },
        );
      },
    );
  }
}

class AccountNameWidget extends StatelessWidget {
  const AccountNameWidget({
    super.key,
    required this.controller,
    required this.accountBloc,
    required this.valueNotifier,
  });
  final TextEditingController controller;
  final AccountsBloc accountBloc;
  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PaisaTextFormField(
          controller: controller,
          label: AppLocalizations.of(context)!.accountNameLabel,
          hintText: AppLocalizations.of(context)!.enterAccountNameLabel,
          keyboardType: TextInputType.name,
          onChanged: (value) {
            valueNotifier.value = value;
            accountBloc.accountName = value;
          },
        );
      },
    );
  }
}

class AccountNumberWidget extends StatelessWidget {
  const AccountNumberWidget({
    super.key,
    required this.controller,
    required this.accountBloc,
    required this.valueNotifier,
  });
  final TextEditingController controller;
  final AccountsBloc accountBloc;
  final ValueNotifier<String> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      maxLength: 4,
      controller: controller,
      label: AppLocalizations.of(context)!.lastFourDigitLabel,
      hintText: AppLocalizations.of(context)!.enterNumberOptionalLabel,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        valueNotifier.value = value;
        accountBloc.accountNumber = value;
      },
    );
  }
}

class AccountInitialAmountWidget extends StatelessWidget {
  const AccountInitialAmountWidget({
    super.key,
    required this.controller,
    required this.accountBloc,
  });
  final TextEditingController controller;
  final AccountsBloc accountBloc;
  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      hintText: AppLocalizations.of(context)!.enterAmountLabel,
      label: AppLocalizations.of(context)!.initialAmountLabel,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        double? amount = double.tryParse(value);
        accountBloc.initialAmount = amount;
      },
    );
  }
}
