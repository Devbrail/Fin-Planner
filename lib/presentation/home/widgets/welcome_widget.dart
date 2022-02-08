import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../bloc/home_bloc.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder(
        buildWhen: (previous, current) => current is UserDetailsChangedState,
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (context, state) {
          if (state is UserDetailsChangedState) {
            return ScreenTypeLayout(
              mobile: Builder(
                builder: (context) {
                  if (state.image.isEmpty) {
                    return CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    );
                  } else {
                    return CircleAvatar(
                      foregroundImage: FileImage(File(state.image)),
                    );
                  }
                },
              ),
              tablet: Column(
                children: [
                  Builder(
                    builder: (context) {
                      if (state.image.isEmpty) {
                        return CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Icon(
                            Icons.account_circle_outlined,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          foregroundImage: FileImage(File(state.image)),
                        );
                      }
                    },
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        AppLocalizations.of(context)!
                            .welcomeMessage(state.name),
                        style:
                            Theme.of(context).textTheme.headline5?.copyWith(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
