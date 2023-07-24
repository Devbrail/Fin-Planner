import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:provider/provider.dart';

class AppFontChanger extends StatelessWidget {
  const AppFontChanger({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Provider.of<Box<dynamic>>(
        context,
        listen: false,
      ).listenable(
        keys: [
          appFontChangerKey,
        ],
      ),
      builder: (context, value, child) {
        return ListTile(
          leading: Icon(MdiIcons.formatFont),
          title: Text(context.loc.fontStyle),
          subtitle: Text(context.loc.fontStyleDescription),
          onTap: () {
            context.goNamed(fontPickerName);
          },
        );
      },
    );
  }
}
