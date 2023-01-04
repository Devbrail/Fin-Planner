import 'package:flutter/material.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../lava/lava_clock.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service_locator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: Material(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(52.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Icon(
                            Icons.wallet,
                            size: 52,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.appTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      'Simple way to help control your savings',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          dense: true,
                          title: Text(
                            'Manage your money with our app',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          dense: true,
                          title: Text(
                            'Easy expense tracking for a better budget',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          dense: true,
                          title: Text(
                            'Stay on top of your expenses, anytime, anywhere',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(28)),
                          onPressed: () => locator
                              .get<Box<dynamic>>(
                                  instanceName: BoxType.settings.stringValue)
                              .put(userIntroKey, true),
                          child: Text(
                            'Get started',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: LavaAnimation(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      mobile: Scaffold(
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
            child: ScreenTypeLayout(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    'Simple way to help control your savings',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        dense: true,
                        title: Text(
                          'Manage your money with our app',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        dense: true,
                        title: Text(
                          'Easy expense tracking for a better budget',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        dense: true,
                        title: Text(
                          'Stay on top of your expenses, anytime, anywhere',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24),
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)),
              onPressed: () {
                locator
                    .get<Box<dynamic>>(
                        instanceName: BoxType.settings.stringValue)
                    .put(userIntroKey, true);
              },
              child: Text(
                'Get started',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
