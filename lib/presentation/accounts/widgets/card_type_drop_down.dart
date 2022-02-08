import 'package:flutter/material.dart';

import '../../../common/enum/card_type.dart';

class CardTypeButtons extends StatefulWidget {
  const CardTypeButtons({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(CardType) onSelected;
  @override
  _CardTypeButtonsState createState() => _CardTypeButtonsState();
}

class _CardTypeButtonsState extends State<CardTypeButtons> {
  CardType selectedType = CardType.cash;

  @override
  void initState() {
    super.initState();
    widget.onSelected(selectedType);
  }

  void _update(CardType type) {
    selectedType = type;
    setState(() {});
    widget.onSelected(type);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: CardType.values.map((type) {
          bool isSelected = selectedType == type;
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
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 300),
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
                      type.name,
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
