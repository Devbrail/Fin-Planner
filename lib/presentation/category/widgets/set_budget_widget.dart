import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetBudgetWidget extends StatefulWidget {
  const SetBudgetWidget({
    super.key,
    required this.controller,
    required this.setBudget,
  });
  final TextEditingController controller;
  final bool setBudget;

  @override
  State<SetBudgetWidget> createState() => _SetBudgetWidgetState();
}

class _SetBudgetWidgetState extends State<SetBudgetWidget> {
  late bool budget = widget.setBudget;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          secondary: Icon(
            Icons.wallet,
            color: Theme.of(context).colorScheme.primary,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(AppLocalizations.of(context)!.budgetLable),
          subtitle: Text(AppLocalizations.of(context)!.setBudgetLable),
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (bool value) {
            setState(() {
              budget = value;
            });
          },
          value: budget,
        ),
        budget
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.budgetLable,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
