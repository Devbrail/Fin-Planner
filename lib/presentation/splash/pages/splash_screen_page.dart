import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../di/service_locator.dart';
import '../bloc/splash_bloc.dart';
import '../widgets/local_grid_view_widget.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({
    Key? key,
    this.forceChangeCurrency = false,
  }) : super(key: key);

  final bool forceChangeCurrency;

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late final splashCubit = locator.get<SplashBloc>()
    ..add(CheckLoginEvent(forceChangeCurrency: widget.forceChangeCurrency));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer(
          listener: (context, state) {
            if (state is NavigateToHome) {
              context.go(landingPath);
            }
          },
          bloc: splashCubit,
          builder: (context, state) {
            if (state is CountryLocalesState) {
              final locales = state.locales.entries.toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.selectedCountryLabel,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Search'),
                    ),
                  ),
                  Expanded(
                    child: ScreenTypeLayout(
                      mobile: LocaleGridView(
                        locales: locales,
                        onPressed: splashCubit.setSelectedLocale,
                        crossAxisCount: 2,
                      ),
                      tablet: LocaleGridView(
                        locales: locales,
                        onPressed: splashCubit.setSelectedLocale,
                        crossAxisCount: 5,
                      ),
                      desktop: LocaleGridView(
                        locales: locales,
                        onPressed: splashCubit.setSelectedLocale,
                        crossAxisCount: 6,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
