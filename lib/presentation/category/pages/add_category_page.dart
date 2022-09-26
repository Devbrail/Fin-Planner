import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/util.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../common/widgets/material_you_textfield.dart';
import '../../../data/category/model/category.dart';
import '../../../di/service_locator.dart';
import '../bloc/category_bloc.dart';
import '../widgets/select_icon_widget.dart';
import '../widgets/set_budget_widget.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final CategoryBloc categoryBloc = locator.get()
    ..add(FetchCategoryFromIdEvent(widget.categoryId));
  late TextEditingController budgetController;
  late TextEditingController categoryController;
  late TextEditingController descController;
  late int? selectedIcon;
  late bool setBudget = _checkBudget();

  Category? category;

  void _submitCategory() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (isAddCategory) {
      categoryBloc.add(
        EditCategoryEvent(
          title: categoryController.text,
          description: descController.text,
          icon: selectedIcon,
          budget: budgetController.text,
        ),
      );
    } else {
      categoryBloc.add(
        CategoryUpdateEvent(
          title: categoryController.text,
          description: descController.text,
          icon: selectedIcon,
          budget: budgetController.text,
          category: category,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoryBloc,
      child: BlocConsumer(
        bloc: categoryBloc,
        listener: (context, state) {
          if (state is CategoryIconSelectedState) {
            selectedIcon = state.categoryIcon;
          }
          if (state is CategoryAddedState) {
            showMaterialSnackBar(
              context,
              isAddCategory
                  ? AppLocalizations.of(context)!.successAddCategoryLabel
                  : AppLocalizations.of(context)!.updatedCategoryLabel,
            );
            context.pop();
          } else if (state is CategoryErrorState) {
            showMaterialSnackBar(context, state.errorString);
          }
        },
        buildWhen: (previous, current) => current is CategorySuccessState,
        builder: (context, state) {
          if (state is CategorySuccessState) {
            category = state.category;
          }
          selectedIcon = category?.icon;
          budgetController =
              TextEditingController(text: category?.budget.toString());
          categoryController = TextEditingController(text: category?.name);
          descController = TextEditingController(text: category?.description);
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: appBar(),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: _inputForm(),
                  ),
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
              appBar: materialYouAppBar(
                context,
                isAddCategory
                    ? AppLocalizations.of(context)!.addCategoryLabel
                    : AppLocalizations.of(context)!.updateCategoryLabel,
                actions: [
                  TextButton(
                    onPressed: _submitCategory,
                    style: TextButton.styleFrom(
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
                        fontSize:
                            Theme.of(context).textTheme.headline6?.fontSize,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SelectIconWidget(
                              codePoint:
                                  selectedIcon ?? MdiIcons.home.codePoint,
                            ),
                            SetBudgetWidget(
                              controller: budgetController,
                              setBudget: setBudget,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _categoryField(),
                            const SizedBox(height: 24),
                            _descriptionField(),
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

  bool get isBudgetActive => category?.budget == null;

  AppBar appBar() {
    return materialYouAppBar(
      context,
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

  Widget _categoryField() {
    return MaterialYouTextFeild(
      controller: categoryController,
      keyboardType: TextInputType.name,
      maxLength: 10,
      label: AppLocalizations.of(context)!.categoryLabel,
      hintText: 'Enter category',
      validator: (value) {
        if (value!.length >= 3 && value.length < 10) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validNameLabel;
        }
      },
    );
  }

  Widget _descriptionField() {
    return MaterialYouTextFeild(
      maxLength: 15,
      controller: descController,
      keyboardType: TextInputType.name,
      label: AppLocalizations.of(context)!.descriptionLabel,
      hintText: 'Enter description',
    );
  }

  Widget _inputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectIconWidget(
          codePoint: selectedIcon ?? MdiIcons.home.codePoint,
        ),
        SetBudgetWidget(
          controller: budgetController,
          setBudget: setBudget,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _categoryField(),
              const SizedBox(height: 16),
              _descriptionField(),
            ],
          ),
        ),
      ],
    );
  }

  bool _checkBudget() {
    final double budget = category?.budget ?? 0.0;
    if (budget > 0.0) {
      return true;
    }
    return false;
  }
}
