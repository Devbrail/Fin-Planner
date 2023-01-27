import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../service_locator.dart';

class WelcomeNameWidget extends StatelessWidget {
  const WelcomeNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .listenable(keys: [userNameKey]),
      builder: (context, value, _) {
        final name = value.get(userNameKey, defaultValue: 'Name');
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                context.loc.welcomeMessage,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color),
              ),
            ],
          ),
        );
      },
    );
  }
}
