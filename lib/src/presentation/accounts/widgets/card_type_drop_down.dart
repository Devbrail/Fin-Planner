import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/card_type.dart';
import '../../widgets/paisa_chip.dart';
import '../bloc/accounts_bloc.dart';

class CardTypeButtons extends StatelessWidget {
  const CardTypeButtons({
    Key? key,
    required this.accountsBloc,
  }) : super(key: key);
  final AccountsBloc accountsBloc;

  void _update(CardType type) {
    accountsBloc.add(UpdateCardTypeEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: accountsBloc,
      buildWhen: (previous, current) => current is UpdateCardTypeState,
      builder: (context, state) {
        return Row(
          children: [
            PaisaMaterialYouChip(
              title: CardType.cash.name,
              isSelected: accountsBloc.selectedType == CardType.cash,
              onPressed: () => _update(CardType.cash),
            ),
            PaisaMaterialYouChip(
              title: CardType.bank.name,
              isSelected: accountsBloc.selectedType == CardType.bank,
              onPressed: () => _update(CardType.bank),
            ),
            PaisaMaterialYouChip(
              title: CardType.wallet.name,
              isSelected: accountsBloc.selectedType == CardType.wallet,
              onPressed: () => _update(CardType.wallet),
            ),
          ],
        );
      },
    );
  }
}
