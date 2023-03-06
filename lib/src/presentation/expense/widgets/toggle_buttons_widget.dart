import 'package:flutter/material.dart';

import '../../../core/enum/transaction.dart';
import '../../widgets/paisa_chip.dart';

class TransactionToggleButtons extends StatefulWidget {
  const TransactionToggleButtons({
    Key? key,
    required this.onSelected,
    required this.selectedType,
  }) : super(key: key);

  final Function(TransactionType) onSelected;
  final TransactionType selectedType;

  @override
  TransactionToggleButtonsState createState() =>
      TransactionToggleButtonsState();
}

class TransactionToggleButtonsState extends State<TransactionToggleButtons> {
  late TransactionType selectedType = widget.selectedType;

  void _update(TransactionType type) {
    selectedType = type;
    setState(() {});
    widget.onSelected(type);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: TransactionType.values
              .map((type) => PaisaMaterialYouChip(
                    title: type.name(context),
                    isSelected: widget.selectedType == type,
                    onPressed: () => _update(type),
                  ))
              .toList(),
        ),
      );
}
