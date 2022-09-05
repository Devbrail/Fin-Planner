import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/theme/custom_color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/currency.dart';

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
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context)
                                .extension<CustomColors>()!
                                .green,
                          ),
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
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.headline6,
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
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.headline6,
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
