import 'package:flutter/material.dart';

class BudgetToggleButtons extends StatefulWidget {
  const BudgetToggleButtons({Key? key}) : super(key: key);

  @override
  State<BudgetToggleButtons> createState() => _BudgetToggleButtonsState();
}

class _BudgetToggleButtonsState extends State<BudgetToggleButtons> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      fillColor: Theme.of(context).colorScheme.primary,
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      borderRadius: BorderRadius.circular(16),
      selectedColor: Theme.of(context).colorScheme.onPrimary,
      textStyle: Theme.of(context).textTheme.subtitle1,
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Budget',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Category',
          ),
        ),
      ],
    );
  }
}
