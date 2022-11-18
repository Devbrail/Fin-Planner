import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../di/service_locator.dart';
import '../../widgets/paisa_text_field.dart';
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
        child: BlocListener(
          listener: (context, state) {
            if (state is NavigateToHome) {
              context.go(landingPath);
            }
          },
          bloc: splashCubit,
          child: Column(
            children: [
              const SizedBox(height: 16),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.language_rounded,
                        size: 72,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.selectedCountryLabel,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PaisaTextFormField(
                  hintText: 'Search',
                  controller: TextEditingController(),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    splashCubit.add(FilterLocaleEvent(value));
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: splashCubit,
                  builder: (context, state) {
                    if (state is CountryLocalesState) {
                      final locales = state.locales;
                      return ScreenTypeLayout(
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
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
