import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../widgets/paisa_card.dart';
import '../bloc/splash_bloc.dart';

class LocaleGridView extends StatelessWidget {
  const LocaleGridView({
    Key? key,
    required this.locales,
    required this.onPressed,
    required this.crossAxisCount,
  }) : super(key: key);

  final List<CountryMap> locales;
  final Function(Locale) onPressed;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 16 / 12,
      ),
      shrinkWrap: true,
      itemCount: locales.length,
      itemBuilder: (_, index) {
        final map = locales[index];
        final format = NumberFormat.compactSimpleCurrency(
          locale: locales[index].locale.toString(),
        );

        return PaisaCard(
          child: InkWell(
            onTap: () => onPressed(locales[index].locale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    format.currencySymbol,
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(map.name),
                  subtitle: Text(
                    '${format.currencyName}',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
