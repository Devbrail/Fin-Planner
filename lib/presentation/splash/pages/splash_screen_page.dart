import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../common/constants/util.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../di/service_locator.dart';
import '../cubit/splash_cubit.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final SplashCubit splashCubit = locator.get();

  @override
  void initState() {
    super.initState();
    splashCubit.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer(
          listener: (context, state) {
            if (state is BiometricErrorState) {
              showMaterialSnackBar(
                context,
                AppLocalizations.of(context)!.errorAuth,
              );
            }
            if (state is NavigateToHome) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                landingScreen,
                (route) => false,
              );
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
                      AppLocalizations.of(context)!.selecteCountry,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ScreenTypeLayout(
                      mobile: LocaleGridView(
                        locales: locales,
                        onPressed: splashCubit.setSeledetdLocale,
                        crossAxisCount: 2,
                      ),
                      tablet: LocaleGridView(
                        locales: locales,
                        onPressed: splashCubit.setSeledetdLocale,
                        crossAxisCount: 5,
                      ),
                      desktop: LocaleGridView(
                        locales: locales,
                        onPressed: splashCubit.setSeledetdLocale,
                        crossAxisCount: 5,
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

class LocaleGridView extends StatelessWidget {
  const LocaleGridView({
    Key? key,
    required this.locales,
    required this.onPressed,
    required this.crossAxisCount,
  }) : super(key: key);

  final List<MapEntry<String, Locale>> locales;
  final Function(Locale) onPressed;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      shrinkWrap: true,
      itemCount: locales.length,
      itemBuilder: (_, index) {
        final format = NumberFormat.compactSimpleCurrency(
          locale: locales[index].value.toString(),
        );
        final map = locales[index];
        return MaterialYouCard(
          child: InkWell(
            onTap: () => onPressed(locales[index].value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    format.currencySymbol,
                    style: GoogleFonts.manrope(
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map.key,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${format.currencyName}',
                      ),
                    ],
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
