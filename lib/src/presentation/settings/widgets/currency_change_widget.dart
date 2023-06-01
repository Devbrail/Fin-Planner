import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:paisa/src/data/currencies/models/country_model.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../bloc/settings_controller.dart';

class CurrencyChangeWidget extends StatelessWidget {
  const CurrencyChangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = getIt.get<SettingsController>();
    late final CountryModel model =
        CountryModel.fromJson(settings.get(userCountryKey));

    return ListTile(
      onTap: () {
        context.pushNamed(
          currencySelectorName,
          queryParams: {
            'force_currency_selector': 'true',
          },
        );
      },
      title: Text(context.loc.currencySign),
      subtitle: Text(model.symbol),
    );
  }
}

class CustomCurrencySymbol extends StatefulWidget {
  const CustomCurrencySymbol({
    super.key,
    required this.settings,
    required this.currentSymbol,
  });

  final SettingsController settings;
  final String currentSymbol;

  @override
  State<CustomCurrencySymbol> createState() => _CustomCurrencySymbolState();
}

class _CustomCurrencySymbolState extends State<CustomCurrencySymbol> {
  final format = NumberFormat("#,##,##0.00", "en_US");
  late final TextEditingController editingController = TextEditingController(
      text: widget.settings.get(userCustomCurrencyKey, defaultValue: ''));
  late String symbol = widget.currentSymbol;
  late bool symbolLeftOrRight = widget.settings.get(
    userCustomCurrencyLeftOrRightKey,
    defaultValue: false,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                context.loc.customSymbol,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListTile(
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Sample: ${symbolLeftOrRight ? symbol : ''}${format.format(1000000)}${symbolLeftOrRight ? '' : symbol}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: false,
                      counterText: "",
                      hintText: context.loc.enterSymbol,
                    ),
                    controller: editingController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        symbol = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            symbolLeftOrRight
                                ? context.loc.leftSymbol
                                : context.loc.rightSymbol,
                          ),
                        ),
                        Switch(
                          value: symbolLeftOrRight,
                          onChanged: (value) {
                            setState(() {
                              symbolLeftOrRight = value;
                            });
                            widget.settings
                                .put(userCustomCurrencyLeftOrRightKey, value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            context.loc.cancel,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onPressed: () {
                          widget.settings
                              .delete(userCustomCurrencyKey)
                              .then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          context.loc.delete,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onPressed: () {
                          if (editingController.text.isNotEmpty) {
                            widget.settings.put(
                                userCustomCurrencyKey, editingController.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(context.loc.done),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
