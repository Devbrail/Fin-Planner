import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../data/category/model/category.dart';
import '../../../service_locator.dart';
import '../bloc/expense_bloc.dart';

class SelectCategoryIcon extends StatelessWidget {
  const SelectCategoryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    return ValueListenableBuilder<Box<Category>>(
      valueListenable: locator.get<Box<Category>>().listenable(),
      builder: (context, value, child) {
        final categories = value.values.toList();
        categories.sort(((a, b) => a.name.compareTo(b.name)));
        if (categories.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addCategoryPath),
            title: Text(AppLocalizations.of(context)!.addCategoryLabel),
            subtitle: Text(AppLocalizations.of(context)!.noCategoryLabel),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        return ScreenTypeLayout(
          tablet: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.selectCategoryLabel,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SelectedItem(
                categories: categories,
                expenseBloc: expenseBloc,
              )
            ],
          ),
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.selectCategoryLabel,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SelectedItem(
                categories: categories,
                expenseBloc: expenseBloc,
              )
            ],
          ),
        );
      },
    );
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    required this.categories,
    required this.expenseBloc,
  });

  final List<Category> categories;
  final ExpenseBloc expenseBloc;

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: expenseBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 4.0,
              runSpacing: 8.0,
              children: List.generate(
                categories.length + 1,
                (index) {
                  if (index == 0) {
                    return FilterChip(
                      onSelected: (value) {},
                      avatar: Icon(
                        color: Theme.of(context).colorScheme.primary,
                        IconData(
                          MdiIcons.plus.codePoint,
                          fontFamily: 'Material Design Icons',
                          fontPackage: 'material_design_icons_flutter',
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      showCheckmark: false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(
                        AppLocalizations.of(context)!.addNewLabel,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                      padding: const EdgeInsets.all(12),
                    );
                  } else {
                    final category = categories[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected:
                            category.key == expenseBloc.selectedCategoryId,
                        onSelected: (value) =>
                            expenseBloc.add(ChangeCategoryEvent(category)),
                        avatar: Icon(
                          color: category.key == expenseBloc.selectedCategoryId
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                          IconData(
                            category.icon,
                            fontFamily: 'Material Design Icons',
                            fontPackage: 'material_design_icons_flutter',
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                          side: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        showCheckmark: false,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Text(category.name),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(
                                color: category.key ==
                                        expenseBloc.selectedCategoryId
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                        padding: const EdgeInsets.all(12),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      );
}
