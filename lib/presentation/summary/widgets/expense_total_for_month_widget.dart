import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/currency.dart';
import '../../../common/theme/custom_color.dart';

class ExpenseTotalForMonthWidget extends StatelessWidget {
  const ExpenseTotalForMonthWidget({
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
          AppLocalizations.of(context)!.thisMonthLabel,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(0.85),
              ),
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
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context)
                                .extension<CustomColors>()!
                                .green,
                          ),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.incomeLabel,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '+${formattedCurrency(income)}',
                    style: GoogleFonts.manrope(
                      textStyle:
                          Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                    ),
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
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context)
                                .extension<CustomColors>()!
                                .red,
                          ),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.outcomeLabel,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '-${formattedCurrency(outcome)}',
                    style: GoogleFonts.manrope(
                      textStyle:
                          Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                    ),
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
