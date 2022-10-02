import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box(BoxType.settings.stringValue)
          .listenable(keys: [userImageKey, userNameKey]),
      builder: (context, value, _) {
        String image = value.get(userImageKey, defaultValue: '');
        if (image == 'no-image') {
          image = '';
        }
        return SafeArea(
          child: ScreenTypeLayout(
            mobile: Builder(
              builder: (context) {
                if (image.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Container(
                        width: 42,
                        height: 42,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      foregroundImage: FileImage(
                        File(image),
                      ),
                    ),
                  );
                }
              },
            ),
            tablet: Builder(
              builder: (context) {
                if (image.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      foregroundImage: FileImage(
                        File(image),
                      ),
                    ),
                  );
                }
              },
            ),
            desktop: Column(
              children: [
                Builder(
                  builder: (context) {
                    if (image.isEmpty) {
                      return CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        foregroundImage: FileImage(
                          File(image),
                        ),
                      );
                    }
                  },
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      AppLocalizations.of(context)!.welcomeMessage,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
