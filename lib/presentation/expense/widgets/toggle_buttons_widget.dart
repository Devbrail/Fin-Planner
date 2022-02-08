import 'package:flutter/material.dart';

import '../../../common/enum/transaction.dart';

class TransactionToggleButtons extends StatefulWidget {
  const TransactionToggleButtons({Key? key, required this.onSelected})
      : super(key: key);

  final Function(TransactonType) onSelected;
  @override
  _TransactionToggleButtonsState createState() =>
      _TransactionToggleButtonsState();
}

class _TransactionToggleButtonsState extends State<TransactionToggleButtons> {
  TransactonType selectedType = TransactonType.expense;
  @override
  void initState() {
    super.initState();
    widget.onSelected(selectedType);
  }

  void _update(TransactonType type) {
    selectedType = type;
    setState(() {});
    widget.onSelected(type);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: TransactonType.values.map((type) {
          final isSelected = selectedType == type;
          final borderRadius = isSelected
              ? BorderRadius.circular(28)
              : BorderRadius.circular(12);
          final colorPrimary = isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary;
          final colorOnPrimary = isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary;
          return Row(
            children: [
              GestureDetector(
                onTap: () => _update(type),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: colorPrimary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Text(
                      type.name(context),
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: colorOnPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8)
            ],
          );
        }).toList(),
      ),
    );
  }
}
