import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/paisa_text_field.dart';

import '../bloc/category_bloc.dart';

class SetBudgetWidget extends StatelessWidget {
  const SetBudgetWidget({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      buildWhen: (previous, current) =>
          current is CategorySuccessState ||
          current is UpdateCategoryBudgetState,
      bloc: BlocProvider.of<CategoryBloc>(context),
      builder: (context, state) {
        bool budget = false;
        if (state is CategorySuccessState) {
          budget = BlocProvider.of<CategoryBloc>(context).isBudgetSet;
        }
        if (state is UpdateCategoryBudgetState) {
          budget = state.isBudget;
        }
        return Column(
          children: [
            SwitchListTile(
              secondary: Icon(
                Icons.wallet,
                color: Theme.of(context).colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text(AppLocalizations.of(context)!.budgetLabel),
              subtitle: Text(AppLocalizations.of(context)!.setBudgetLabel),
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (bool value) => BlocProvider.of<CategoryBloc>(context)
                  .add(UpdateCategoryBudgetEvent(value)),
              value: budget,
            ),
            Builder(
              builder: (context) {
                return budget
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CategoryBudgetWidget(controller: controller),
                      )
                    : const SizedBox.shrink();
              },
            )
          ],
        );
      },
    );
  }
}

class CategoryBudgetWidget extends StatelessWidget {
  const CategoryBudgetWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      hintText: AppLocalizations.of(context)!.enterBudgetLabel,
      label: AppLocalizations.of(context)!.budgetLabel,
      onChanged: (value) {
        double? amount = double.tryParse(value);
        BlocProvider.of<CategoryBloc>(context).categoryBudget = amount;
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
    );
  }
}
