import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../bloc/settings_controller.dart';

class CurrencyChangeWidget extends StatelessWidget {
  const CurrencyChangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = getIt.get<SettingsController>();
    final String customSymbol =
        settings.get(userCustomCurrencyKey, defaultValue: '');
    final String currentSymbol = NumberFormat.compactSimpleCurrency(
                locale: settings.get(userLanguageKey))
            .currencyName ??
        '';
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      context.loc.currencySign,
                      style: context.titleLarge,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      context.pushNamed(
                        currencySelectorName,
                        queryParameters: {
                          'force_currency_selector': 'true',
                        },
                      );
                    },
                    title: Text(
                      context.loc.selectCurrency,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showCustomCurrencySymbol(context, settings);
                    },
                    title: Text(
                      context.loc.customSymbol,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      title: Text(context.loc.currencySign),
      subtitle: Text(
        customSymbol.isNotEmpty ? customSymbol : currentSymbol,
      ),
    );
  }
}

void _showCustomCurrencySymbol(
  BuildContext context,
  SettingsController settings,
) {
  showModalBottomSheet(
    constraints: BoxConstraints(
      maxWidth:
          MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
    ),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return CustomCurrencySymbol(
        settings: settings,
        currentSymbol: settings.get(userCustomCurrencyKey, defaultValue: '\$'),
      );
    },
  );
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
                style: context.titleLarge,
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
                      style: context.titleSmall,
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
                            color: context.error,
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
