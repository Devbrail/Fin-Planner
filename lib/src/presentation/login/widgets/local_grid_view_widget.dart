import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../core/constants.dart';
import '../../../core/enum/box_types.dart';
import '../../../data/currencies/models/currency_model.dart';
import '../../widgets/paisa_card.dart';

class LocaleGridView extends StatefulWidget {
  const LocaleGridView({
    Key? key,
    required this.locales,
    required this.onPressed,
    required this.crossAxisCount,
  }) : super(key: key);

  final List<CurrencyModel> locales;
  final Function(Locale) onPressed;
  final int crossAxisCount;

  @override
  State<LocaleGridView> createState() => _LocaleGridViewState();
}

class _LocaleGridViewState extends State<LocaleGridView> {
  final Box<dynamic> settings =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

  late CurrencyModel? selectedIndex = widget.locales.firstWhere(
    (element) =>
        element.locale.languageCode ==
        (settings.get(userLanguageKey, defaultValue: 'DEF') as String),
    orElse: () => CurrencyModel("US Dollar", const Locale('en')),
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 82, left: 8, right: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: 16 / 12,
      ),
      shrinkWrap: true,
      itemCount: widget.locales.length,
      itemBuilder: (_, index) {
        final map = widget.locales[index];
        final format = NumberFormat.compactSimpleCurrency(
          locale: widget.locales[index].locale.toString(),
        );

        return PaisaCard(
          color: Theme.of(context).colorScheme.surface,
          shape: selectedIndex == map
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : null,
          child: InkWell(
            onTap: () {
              setState(() {
                selectedIndex = map;
              });
              widget.onPressed(map.locale);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16,
                  ),
                  child: Text(
                    format.currencySymbol,
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                const Spacer(),
                ListTile(
                  title: Text(
                    map.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${format.currencyName}',
                    overflow: TextOverflow.ellipsis,
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
