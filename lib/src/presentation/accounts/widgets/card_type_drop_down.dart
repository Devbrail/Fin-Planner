import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';
import '../../widgets/paisa_pill_chip.dart';
import '../bloc/accounts_bloc.dart';

class CardTypeButtons extends StatelessWidget {
  const CardTypeButtons({Key? key}) : super(key: key);

  void _update(BuildContext context, CardType type) {
    BlocProvider.of<AccountsBloc>(context).add(UpdateCardTypeEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      buildWhen: (previous, current) => current is UpdateCardTypeState,
      builder: (context, state) {
        return Row(
          children: [
            PaisaPillChip(
              title: CardType.cash.stringValue(context),
              isSelected: BlocProvider.of<AccountsBloc>(context).selectedType ==
                  CardType.cash,
              onPressed: () => _update(context, CardType.cash),
            ),
            PaisaPillChip(
              title: CardType.bank.stringValue(context),
              isSelected: BlocProvider.of<AccountsBloc>(context).selectedType ==
                  CardType.bank,
              onPressed: () => _update(context, CardType.bank),
            ),
            PaisaPillChip(
              title: CardType.wallet.stringValue(context),
              isSelected: BlocProvider.of<AccountsBloc>(context).selectedType ==
                  CardType.wallet,
              onPressed: () => _update(context, CardType.wallet),
            ),
          ],
        );
      },
    );
  }
}
