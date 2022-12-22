import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common.dart';
import '../home/bloc/home_bloc.dart';

class PaisaTitleWidget extends StatelessWidget {
  const PaisaTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<HomeBloc>(),
      builder: (context, state) {
        if (state is CurrentIndexState) {
          return Text(
            state.currentPage.name(context),
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
