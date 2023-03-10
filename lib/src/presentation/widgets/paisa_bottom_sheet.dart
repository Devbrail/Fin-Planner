import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../main.dart';

import '../../core/common.dart';
import '../../core/enum/box_types.dart';

enum UserMenuPopup { debts, chooseTheme, settings, userDetails }

Future<void> paisaBottomSheet(
  BuildContext context,
  Widget child,
) =>
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SafeArea(
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );

Future<T?> paisaAlertDialog<T>(
  BuildContext context, {
  required Widget child,
  required Widget title,
  required Widget confirmationButton,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: child,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.loc.cancelLabel),
          ),
          confirmationButton,
        ],
      ),
    );

Future<void> showUserDialog(
  BuildContext context, {
  required Function(UserMenuPopup userMenuPopup) userMenuPopup,
}) {
  final settings = getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);
  final int themeModeValue = settings.get(themeModeKey, defaultValue: 0);
  var themeMode = ThemeMode.values[themeModeValue];
  bool isDarkMode = themeMode == ThemeMode.dark;
  return showDialog<void>(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: MediaQuery.of(context)
              .viewInsets
              .copyWith(top: kToolbarHeight + 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    Material(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<Box>(
                            valueListenable: getIt
                                .get<Box<dynamic>>(
                                    instanceName: BoxType.settings.name)
                                .listenable(
                              keys: [userImageKey, userNameKey],
                            ),
                            builder: (context, value, _) {
                              String image =
                                  value.get(userImageKey, defaultValue: '');
                              if (image == 'no-image') {
                                image = '';
                              }
                              final name =
                                  value.get(userNameKey, defaultValue: 'Name');
                              return ListTile(
                                onTap: () => userMenuPopup
                                    .call(UserMenuPopup.userDetails),
                                leading: Builder(
                                  builder: (context) {
                                    if (image.isEmpty) {
                                      return ClipOval(
                                        child: Container(
                                          width: 42,
                                          height: 42,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                          child: Icon(
                                            Icons.account_circle_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: CircleAvatar(
                                          foregroundImage:
                                              FileImage(File(image)),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                title: Text(name),
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            dense: true,
                            onTap: () => userMenuPopup(UserMenuPopup.debts),
                            leading: Icon(
                              MdiIcons.accountCashOutline,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            title: Text(
                              context.loc.debtsLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            dense: true,
                            onTap: () =>
                                userMenuPopup(UserMenuPopup.chooseTheme),
                            leading: Icon(
                              isDarkMode
                                  ? MdiIcons.brightness5
                                  : MdiIcons.brightness4,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            title: Text(
                              context.loc.chooseThemeLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            dense: true,
                            onTap: () => userMenuPopup(UserMenuPopup.settings),
                            leading: Icon(
                              MdiIcons.cog,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            title: Text(
                              context.loc.settingsLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
