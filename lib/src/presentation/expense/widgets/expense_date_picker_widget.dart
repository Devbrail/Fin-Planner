import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/common.dart';
import '../bloc/expense_bloc.dart';

class ExpenseDatePickerWidget extends StatefulWidget {
  const ExpenseDatePickerWidget({
    super.key,
  });

  @override
  State<ExpenseDatePickerWidget> createState() =>
      _ExpenseDatePickerWidgetState();
}

class _ExpenseDatePickerWidgetState extends State<ExpenseDatePickerWidget> {
  late DateTime selectedDateTime =
      BlocProvider.of<ExpenseBloc>(context).selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: () async {
              final DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: selectedDateTime,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                setState(() {
                  selectedDateTime = selectedDateTime.copyWith(
                    day: dateTime.day,
                    month: dateTime.month,
                    year: dateTime.year,
                  );
                  BlocProvider.of<ExpenseBloc>(context).selectedDate =
                      selectedDateTime;
                });
              }
            },
            leading: Icon(
              Icons.today_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(selectedDateTime.formattedDate),
          ),
        ),
        Expanded(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.dialOnly,
              );
              if (timeOfDay != null) {
                setState(() {
                  selectedDateTime = selectedDateTime.copyWith(
                    hour: timeOfDay.hour,
                    minute: timeOfDay.minute,
                  );
                  BlocProvider.of<ExpenseBloc>(context).selectedDate =
                      selectedDateTime;
                });
              }
            },
            leading: Icon(
              MdiIcons.clockOutline,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(selectedDateTime.formattedTime),
          ),
        ),
      ],
    );
  }
}
