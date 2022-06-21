import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.imageLable,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  AppLocalizations.of(context)!.imageDesc,
                  style: Theme.of(context).textTheme.headline6,
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
      bottomNavigationBar: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => context.pop(),
                child: Text(AppLocalizations.of(context)!.backLable),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => context.go(splashScreen),
                child: Text(AppLocalizations.of(context)!.nextLable),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
