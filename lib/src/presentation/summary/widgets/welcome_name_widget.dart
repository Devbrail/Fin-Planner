import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/src/presentation/home/bloc/home_bloc.dart';
import 'package:paisa/src/presentation/widgets/paisa_user_widget.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';

class WelcomeNameWidget extends StatelessWidget {
  const WelcomeNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(keys: [userNameKey]),
      builder: (context, value, _) {
        final name = value.get(userNameKey, defaultValue: 'Name');
        return ListTile(
          trailing: PaisaUserWidget(
            homeBloc: BlocProvider.of<HomeBloc>(context),
          ),
          title: Text(
            name,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              textStyle: Theme.of(context).textTheme.titleLarge,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          subtitle: Text(
            context.loc.welcomeMessage,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
          ),
        );
      },
    );
  }
}
