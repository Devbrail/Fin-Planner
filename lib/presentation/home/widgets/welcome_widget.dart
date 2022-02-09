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
        final name = value.get(userNameKey, defaultValue: 'Name');
        final image = value.get(userImageKey, defaultValue: '');
        return SafeArea(
            child: ScreenTypeLayout(
          mobile: Builder(
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
                return CircleAvatar(foregroundImage: FileImage(File(image)));
              }
            },
          ),
          tablet: Column(
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
                        foregroundImage: FileImage(File(image)));
                  }
                },
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    AppLocalizations.of(context)!.welcomeMessage(name),
                    style: Theme.of(context).textTheme.headline5?.copyWith(),
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
