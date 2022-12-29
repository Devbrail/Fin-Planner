import 'package:flutter/material.dart';
import 'package:flutter_paisa/src/core/common.dart';
import 'package:flutter_paisa/src/core/enum/box_types.dart';
import 'package:flutter_paisa/src/lava/lava_clock.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/src/service_locator.dart';
import 'package:hive_flutter/adapters.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LavaAnimation(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                'Let\'s manage your expenses',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(24)),
            onPressed: () {
              locator
                  .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
                  .put(userIntroKey, true);
            },
            child: Text(
              'Let\'s start saving',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
