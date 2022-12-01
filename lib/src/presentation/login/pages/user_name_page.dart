import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/src/core/enum/box_types.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../service_locator.dart';

class UserNamePage extends StatelessWidget {
  UserNamePage({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      key: const Key('user_name_page_view'),
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .listenable(
        keys: [userNameKey],
      ),
      builder: (context, value, _) {
        return Scaffold(
          key: const Key('user_name_scaffold'),
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                      child: const Icon(
                        Icons.wallet,
                        size: 72,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        text: AppLocalizations.of(context)!.welcomeLabel,
                        children: [
                          TextSpan(
                            text: ' ${AppLocalizations.of(context)!.appTitle}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppLocalizations.of(context)!.welcomeDescLabel,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.75),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formState,
                      child: TextFormField(
                        key: const Key('user_name_textfield'),
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.enterNameLabel,
                          label: Text(AppLocalizations.of(context)!.nameLabel),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val!.length >= 3) {
                            return null;
                          } else {
                            return AppLocalizations.of(context)!.enterNameLabel;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (_formState.currentState!.validate()) {
                value
                    .put(userNameKey, _nameController.text)
                    .then((value) => context.go(userImagePath));
              }
            },
            extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
            label: const Icon(MdiIcons.arrowRight),
            icon: Text(AppLocalizations.of(context)!.nextLabel),
          ),
        );
      },
    );
  }
}
