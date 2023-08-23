import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/enum/calender_formats.dart';
import 'package:paisa/main.dart';

class ChooseCalenderFormatWidget extends StatefulWidget {
  const ChooseCalenderFormatWidget({
    Key? key,
    this.currentFormat,
  }) : super(key: key);

  final CalenderFormats? currentFormat;

  @override
  ChooseCalenderFormatWidgetState createState() =>
      ChooseCalenderFormatWidgetState();
}

class ChooseCalenderFormatWidgetState
    extends State<ChooseCalenderFormatWidget> {
  late CalenderFormats currentIndex =
      widget.currentFormat ?? CalenderFormats.mmddyyyy;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              context.loc.calenderFormat,
              style: context.titleLarge,
            ),
          ),
          ...CalenderFormats.values
              .map(
                (e) => RadioListTile<CalenderFormats>(
                  value: e,
                  activeColor: context.primary,
                  groupValue: currentIndex,
                  onChanged: (CalenderFormats? value) {
                    currentIndex = value!;
                    setState(() {});
                  },
                  title: Text(
                    e.exampleValue,
                    style: TextStyle(
                      color: context.onSurface,
                    ),
                  ),
                ),
              )
              .toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    context.loc.cancel,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => getIt
                      .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                      .put(calenderFormatKey, currentIndex.index)
                      .then((value) => Navigator.pop(context)),
                  child: Text(context.loc.ok),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
