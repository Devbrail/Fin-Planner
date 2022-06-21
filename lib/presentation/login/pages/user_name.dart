import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../app/routes.dart';
import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';

class UserNamePage extends StatelessWidget {
  UserNamePage({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box(BoxType.settings.stringValue).listenable(
        keys: [userNameKey],
      ),
      builder: (context, value, _) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                          text: AppLocalizations.of(context)!.welcomeLable,
                          children: [
                            TextSpan(
                              text:
                                  ' ${AppLocalizations.of(context)!.appTitle}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ]),
                    ),
                    Text(
                      AppLocalizations.of(context)!.welcomeDescLable,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formState,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.name,
                        ),
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val!.length > 3) {
                            return null;
                          } else {
                            return AppLocalizations.of(context)!.enterName;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formState.currentState!.validate()) {
                        value.put(userNameKey, _nameController.text).then(
                            (value) => context.pushNamed(userImageScreen));
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.nextLable),
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
