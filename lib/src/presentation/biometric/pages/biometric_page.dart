import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../widgets/paisa_big_button_widget.dart';
import '../bloc/biometric_bloc.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  final BiometricBloc biometricCubit = getIt.get()..add(CheckBiometricEvent());
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: biometricCubit,
      listener: (context, state) {
        if (state is NavigateToHome) {
          context.go(landingPath);
        }
      },
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PaisaBigButton(
              onPressed: () {
                biometricCubit.add(CheckBiometricEvent());
              },
              title: context.loc.authenticate,
            ),
          ),
        ),
        appBar: AppBar(),
        body: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                MdiIcons.lock,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              context.loc.paisaLocked,
              style: GoogleFonts.outfit(
                textStyle: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      MdiIcons.fingerprint,
                      size: 72,
                    ),
                    Text(
                      context.loc.biometricMessage,
                      style: GoogleFonts.outfit(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
