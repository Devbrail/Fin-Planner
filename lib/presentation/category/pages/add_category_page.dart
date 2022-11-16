import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/context_extensions.dart';
import '../../widgets/paisa_text_field.dart';
import '../../../di/service_locator.dart';
import '../bloc/category_bloc.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/select_icon_widget.dart';
import '../widgets/set_budget_widget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({
    Key? key,
    this.categoryId,
  }) : super(key: key);

  final String? categoryId;

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  late final CategoryBloc categoryBloc = locator.get()
    ..add(FetchCategoryFromIdEvent(widget.categoryId));
  late TextEditingController budgetController = TextEditingController();
  late TextEditingController categoryController = TextEditingController();
  late TextEditingController descController = TextEditingController();

  void _submitCategory() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    categoryBloc.add(AddOrUpdateCategoryEvent(isAddCategory));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoryBloc,
      child: BlocConsumer(
        bloc: categoryBloc,
        listener: (context, state) {
          if (state is CategoryAddedState) {
            context.showMaterialSnackBar(
              isAddCategory
                  ? AppLocalizations.of(context)!.successAddCategoryLabel
                  : AppLocalizations.of(context)!.updatedCategoryLabel,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            );
            context.pop();
          } else if (state is CategoryErrorState) {
            context.showMaterialSnackBar(
              state.errorString,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              color: Theme.of(context).colorScheme.onErrorContainer,
            );
          } else if (state is CategorySuccessState) {
            budgetController.text = state.category.budget.toString();
            budgetController.selection = TextSelection.collapsed(
              offset: state.category.budget.toString().length,
            );

            categoryController.text = state.category.name;
            categoryController.selection = TextSelection.collapsed(
              offset: state.category.name.length,
            );

            descController.text = state.category.description;
            descController.selection = TextSelection.collapsed(
              offset: state.category.description.length,
            );
          } else if (state is CategoryIconSelectedState) {
            categoryBloc.selectedIcon = state.categoryIcon;
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: appBar(),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: _inputForm(),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _submitButton(),
                ),
              ),
            ),
            tablet: Scaffold(
              appBar: context.materialYouAppBar(
                isAddCategory
                    ? AppLocalizations.of(context)!.addCategoryLabel
                    : AppLocalizations.of(context)!.updateCategoryLabel,
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SelectIconWidget(),
                            SetBudgetWidget(controller: budgetController),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CategoryNameWidget(controller: categoryController),
                            const SizedBox(height: 24),
                            CategoryDescriptionWidget(
                                controller: descController),
                            const SizedBox(height: 24),
                            _submitButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool get isAddCategory => widget.categoryId == null;

  AppBar appBar() {
    return context.materialYouAppBar(
      isAddCategory
          ? AppLocalizations.of(context)!.addCategoryLabel
          : AppLocalizations.of(context)!.updateCategoryLabel,
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: _submitCategory,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(
        isAddCategory
            ? AppLocalizations.of(context)!.addCategoryLabel
            : AppLocalizations.of(context)!.updateLabel,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Theme.of(context).textTheme.headline6?.fontSize,
        ),
      ),
    );
  }

  Widget _inputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SelectIconWidget(),
        SetBudgetWidget(controller: budgetController),
        const ColorPickerWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              CategoryNameWidget(controller: categoryController),
              const SizedBox(height: 16),
              CategoryDescriptionWidget(controller: descController),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryNameWidget extends StatelessWidget {
  const CategoryNameWidget({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      hintText: AppLocalizations.of(context)!.enterCategoryLabel,
      label: AppLocalizations.of(context)!.categoryLabel,
      keyboardType: TextInputType.name,
      onChanged: (value) =>
          BlocProvider.of<CategoryBloc>(context).categoryTitle = value,
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validNameLabel;
        }
      },
    );
  }
}

class CategoryDescriptionWidget extends StatelessWidget {
  const CategoryDescriptionWidget({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PaisaTextFormField(
      controller: controller,
      hintText: AppLocalizations.of(context)!.enterDescriptionLabel,
      keyboardType: TextInputType.name,
      label: AppLocalizations.of(context)!.descriptionLabel,
      onChanged: (value) =>
          BlocProvider.of<CategoryBloc>(context).categoryDesc = value,
    );
  }
}
