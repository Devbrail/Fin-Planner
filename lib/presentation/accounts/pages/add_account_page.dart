import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/theme.dart';
import '../../../common/constants/util.dart';
import '../../../common/enum/card_type.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../data/accounts/model/account.dart';
import '../../../di/service_locator.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/account_card.dart';
import '../widgets/card_type_drop_down.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({
    Key? key,
    this.account,
  }) : super(key: key);

  final Account? account;

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  late final cardNumberController = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  late final cardHolderController = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  late final bankNameController = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  final AccountsBloc accountsBloc = locator.get();
  String selectedDateString = '';
  DateTime selectedDate = DateTime.now();
  CardType selectedType = CardType.cash;

  @override
  void initState() {
    super.initState();
    cardHolderController.value = TextEditingValue(
      text: widget.account?.name ?? '',
    );
    cardNumberController.value = TextEditingValue(
      text: widget.account?.number ?? '',
    );
    bankNameController.value = TextEditingValue(
      text: widget.account?.bankName ?? '',
    );
    selectedDate = widget.account?.validThru ?? DateTime.now();
    selectedType = widget.account?.cardType ?? CardType.cash;
  }

  bool get isAddOrUpdate => widget.account == null;
  void _addOrUpddateAccount() {
    if (isAddOrUpdate) {
      accountsBloc.add(
        AddAccountEvent(
          bankName: bankNameController.text,
          icon: Icons.credit_card.codePoint,
          holderName: cardHolderController.text,
          number: cardNumberController.text,
          validThru: selectedDate,
          cardType: selectedType,
        ),
      );
    } else {
      widget.account!
        ..bankName = bankNameController.text
        ..cardType = selectedType
        ..name = cardHolderController.text
        ..validThru = selectedDate
        ..number = cardNumberController.text
        ..save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: accountsBloc,
      listener: (context, state) {
        if (state is AddAccountState) {
          showMaterialSnackBar(
            context,
            isAddOrUpdate
                ? AppLocalizations.of(context)!.addedCard
                : AppLocalizations.of(context)!.updatedCard,
          );
          Navigator.pop(context);
        }
        if (state is AccountDeletedState) {
          showMaterialSnackBar(
            context,
            AppLocalizations.of(context)!.deletedCard,
          );
          Navigator.pop(context);
        }
      },
      child: ScreenTypeLayout(
        mobile: Scaffold(
          appBar: materialYouAppBar(
            context,
            AppLocalizations.of(context)!.addCard,
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _addOrUpddateAccount,
                child: Text(
                  AppLocalizations.of(context)!.addCard,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: context.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
          body: ScreenTypeLayout(
            mobile: SingleChildScrollView(
              child: Column(
                children: [
                  AccountCard(
                    cardNumber: cardNumberController.value.text,
                    cardHolder: cardHolderController.value.text,
                    bankName: bankNameController.value.text,
                    cardType: selectedType,
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CardTypeButtons(onSelected: (cardType) {
                            selectedType = cardType;
                          }),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: cardHolderController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.cardHoder,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: bankNameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.accountName,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: cardNumberController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.lastFourDigit,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        tablet: Scaffold(
          appBar: materialYouAppBar(
            context,
            AppLocalizations.of(context)!.addCard,
          ),
          body: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AccountCard(
                    cardNumber: cardNumberController.value.text,
                    cardHolder: cardHolderController.value.text,
                    bankName: bankNameController.value.text,
                    cardType: selectedType,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      children: [
                        Form(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CardTypeButtons(onSelected: (cardType) {
                                  selectedType = cardType;
                                }),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: cardHolderController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.cardHoder,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: bankNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .accountName,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: cardNumberController,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .lastFourDigit,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    accountsBloc.add(
                                      AddAccountEvent(
                                        bankName: bankNameController.text,
                                        icon: Icons.credit_card.codePoint,
                                        holderName: cardHolderController.text,
                                        number: cardNumberController.text,
                                        validThru: selectedDate,
                                        cardType: selectedType,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.addCard,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          color: context.onPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatedDate(DateTime date) => DateFormat('MM/yyyy').format(date);
}
