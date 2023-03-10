import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../core/enum/card_type.dart';
import '../../../widgets/lava/lava_clock.dart';
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
  late final bool isAccountAddOrUpdate = widget.accountId == null;
  late final accountsBloc = getIt.get<AccountsBloc>()
    ..add(FetchAccountFromIdEvent(widget.accountId));
  final ValueNotifier<String> accountNameNotifier =
      ValueNotifier('Account Name');
  final ValueNotifier<String> accountNumberNotifier = ValueNotifier('0000');
  final ValueNotifier<String> accountHolderNotifier =
      ValueNotifier('Holder Name');

  final accountNumberController = TextEditingController();
  final accountHolderController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountInitialAmountController = TextEditingController();

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
    return BlocProvider(
      create: (context) => accountsBloc,
      child: BlocConsumer(
        bloc: accountsBloc,
        listener: (context, state) {
          if (state is AddAccountState) {
            context.showMaterialSnackBar(
              isAccountAddOrUpdate
                  ? context.loc.addedCardLabel
                  : context.loc.updatedCardLabel,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            );
            context.pop();
          }
          if (state is AccountDeletedState) {
            context.showMaterialSnackBar(
              context.loc.deletedCardLabel,
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
            accountNameController.selection =
                TextSelection.collapsed(offset: state.account.bankName.length);

            accountNumberNotifier.value = state.account.number;
            accountNumberController.text = state.account.number;
            accountNumberController.selection =
                TextSelection.collapsed(offset: state.account.number.length);

            accountHolderNotifier.value = state.account.name;
            accountHolderController.text = state.account.name;
            accountHolderController.selection =
                TextSelection.collapsed(offset: state.account.name.length);

            accountInitialAmountController.text =
                state.account.amount.toString();
            accountInitialAmountController.selection = TextSelection.collapsed(
                offset: state.account.amount.toString().length);
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout.builder(
            mobile: (_) => Scaffold(
              appBar: context.materialYouAppBar(
                isAccountAddOrUpdate
                    ? context.loc.addCardLabel
                    : context.loc.updateCardLabel,
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
                        onSelected: (cardType) =>
                            accountsBloc.add(UpdateCardTypeEvent(cardType)),
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
                                        state.cardType == CardType.wallet)) {
                                  return AccountInitialAmountWidget(
                                    controller: accountInitialAmountController,
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
                      accountsBloc
                          .add(AddOrUpdateAccountEvent(isAccountAddOrUpdate));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text(
                      isAccountAddOrUpdate
                          ? context.loc.addCardLabel
                          : context.loc.updateLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            tablet: (_) => Scaffold(
              appBar: context.materialYouAppBar(
                context.loc.addCardLabel,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  context.loc.addCardLabel,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge
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
                    context.loc.accountInfoLabel,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    context.loc.accountInfoDescLabel,
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
                        context.loc.acceptLabel,
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
          label: context.loc.cardHolderLabel,
          hintText: context.loc.enterCardHolderNameLabel,
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
          label: context.loc.accountNameLabel,
          hintText: context.loc.enterAccountNameLabel,
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
      label: context.loc.lastFourDigitLabel,
      hintText: context.loc.enterNumberOptionalLabel,
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
      hintText: context.loc.enterAmountLabel,
      label: context.loc.initialAmountLabel,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        double? amount = double.tryParse(value);
        accountBloc.initialAmount = amount;
      },
    );
  }
}
