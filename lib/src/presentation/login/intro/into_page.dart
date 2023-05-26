import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../widgets/lava/lava_clock.dart';
import '../../widgets/paisa_annotate_region_widget.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      tablet: const IntroBigScreenWidget(),
      mobile: const IntoMobileWidget(),
    );
  }
}

class IntroBigScreenWidget extends StatelessWidget {
  const IntroBigScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      child: Material(
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
                          context.loc.appTitle,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      context.loc.intoTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
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
                            context.loc.intoSummary1,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
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
                            context.loc.intoSummary2,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
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
                            context.loc.intoSummary3,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
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
                          onPressed: () => getIt
                              .get<Box<dynamic>>(
                                  instanceName: BoxType.settings.name)
                              .put(userIntroKey, true),
                          child: Text(
                            context.loc.introCTA,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
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
    );
  }
}

class IntoMobileWidget extends StatelessWidget {
  const IntoMobileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LavaAnimation(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.loc.appTitle,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  context.loc.intoTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      dense: true,
                      title: Text(
                        context.loc.intoSummary1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      dense: true,
                      title: Text(
                        context.loc.intoSummary2,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      dense: true,
                      title: Text(
                        context.loc.intoSummary3,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    '*This app still in beta, expect the unexpected behavior and UI changes',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)),
            onPressed: () {
              getIt
                  .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                  .put(userIntroKey, true);
            },
            child: Text(
              context.loc.introCTA,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
