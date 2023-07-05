import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../domain/category/entities/category.dart';
import '../bloc/transaction_bloc.dart';
import 'select_category_widget.dart';

class TransferCategoriesWidget extends StatelessWidget {
  const TransferCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionBloc>(context).add(FetchDefaultCategoryEvent());
    return BlocBuilder<TransactionBloc, TransactionState>(
      buildWhen: (previous, current) => current is DefaultCategoriesState,
      builder: (context, state) {
        if (state is DefaultCategoriesState) {
          if (state.categories.isEmpty) {
            return ListTile(
              onTap: () async {
                await context.pushNamed(addCategoryName);
                if (context.mounted) {
                  BlocProvider.of<TransactionBloc>(context)
                      .add(FetchDefaultCategoryEvent());
                }
              },
              title: Text(context.loc.addCategoryEmptyTitle),
              subtitle: Text(context.loc.addCategoryEmptySubTitle),
              trailing: const Icon(Icons.keyboard_arrow_right),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    context.loc.selectCategory,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SelectDefaultCategoryWidget(
                  categories: state.categories,
                ),
              ],
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class SelectDefaultCategoryWidget extends StatelessWidget {
  const SelectDefaultCategoryWidget({
    super.key,
    required this.categories,
  });
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final expenseBloc = BlocProvider.of<TransactionBloc>(context);
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: List.generate(
              categories.length + 1,
              (index) {
                if (index == 0) {
                  return CategoryChip(
                    selected: false,
                    onSelected: (p0) => context.pushNamed(addCategoryPath),
                    icon: MdiIcons.plus.codePoint,
                    title: context.loc.addNew,
                    iconColor: context.primary,
                    titleColor: context.primary,
                  );
                } else {
                  final Category category = categories[index - 1];
                  final bool selected =
                      category.superId == expenseBloc.selectedCategoryId;
                  return CategoryChip(
                    selected: selected,
                    onSelected: (value) =>
                        expenseBloc.add(ChangeCategoryEvent(category)),
                    icon: category.icon,
                    title: category.name,
                    titleColor: Color(category.color ?? context.primary.value),
                    iconColor: Color(category.color ?? context.primary.value),
                  );
                }
              },
            ),
          ),
        );
      },
    );
    /*  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final CategoryModel model = widget.categories[index];
          return Container(
            decoration: model == selectedModel
                ? BoxDecoration(
                    border: Border.all(color: context.primary),
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              isSelected: model == selectedModel,
              onPressed: () {
                setState(() {
                  selectedModel = model;
                });
                
              },
              icon: Icon(
                IconData(
                  model.icon,
                  fontFamily: fontFamilyName,
                  fontPackage: fontFamilyPackageName,
                ),
              ),
            ),
          );
        },
      ),
    ); */
  }
}
