import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../app/routes.dart';
import '../../../common/enum/box_types.dart';
import '../../../data/settings/settings_service.dart';
import '../../home/bloc/home_bloc.dart';
import '../../settings/widgets/user_profile_widget.dart';

class UserImagePage extends StatefulWidget {
  const UserImagePage({Key? key}) : super(key: key);

  @override
  State<UserImagePage> createState() => _UserImagePageState();
}

class _UserImagePageState extends State<UserImagePage> {
  void _pickImage() => expenseBloc.add(PickImageEvent());
  late final expenseBloc = BlocProvider.of<HomeBloc>(context);
  late final value = Hive.box(BoxType.settings.stringValue);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.imageLabel,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  AppLocalizations.of(context)!.imageDescLabel,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 16),
                UserImageWidget(
                  pickImage: _pickImage,
                  maxRadius: 42,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  child: Text(AppLocalizations.of(context)!.backLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final String image =
                        value.get(userImageKey, defaultValue: '');
                    if (image.isEmpty) {
                      value.put(userImageKey, 'no-image');
                    }
                    context.go(splashPath);
                  },
                  child: Text(AppLocalizations.of(context)!.nextLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
