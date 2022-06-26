import 'package:flutter/material.dart';
import 'package:flutter_paisa/common/constants/currency.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpsenseTotalForMonthWidget extends StatelessWidget {
  const ExpsenseTotalForMonthWidget({
    Key? key,
    this.income = 0,
    required this.outcome,
  }) : super(key: key);

  final double income;
  final double outcome;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.thisMonthLable,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '▼',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.green.shade300),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.incomeLable,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '+${formattedCurrency(income)}',
                    style: Theme.of(context).textTheme.headline6?.copyWith(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '▲',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.red.shade300),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.outcomeLable,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '-${formattedCurrency(outcome)}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
