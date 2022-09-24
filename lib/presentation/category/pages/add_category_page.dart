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
    this.category,
  }) : super(key: key);

  final Category? category;

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final addCategoryBloc = locator.get<CategoryBloc>();
  final formKey = GlobalKey<FormState>();
  late final budgetController =
      TextEditingController(text: widget.category?.budget.toString() ?? '');
  late final categoryController =
      TextEditingController(text: widget.category?.name ?? '');
  late final descController =
      TextEditingController(text: widget.category?.description ?? '');
  late int selectedIcon = widget.category?.icon ?? MdiIcons.home.codePoint;
  late bool setBudget = _checkBudget();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: addCategoryBloc,
      listener: (context, state) {
        if (state is CategoryAddedState) {
          showMaterialSnackBar(
            context,
            isAddCategory
                ? AppLocalizations.of(context)!.successAddCategoryLable
                : AppLocalizations.of(context)!.updatedCategoryLable,
          );
          context.pop();
        }
      },
      child: ScreenTypeLayout(
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
                ? AppLocalizations.of(context)!.addCategoryLable
                : AppLocalizations.of(context)!.updateCategoryLable,
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
                      ? AppLocalizations.of(context)!.addCategoryLable
                      : AppLocalizations.of(context)!.updateLable,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Theme.of(context).textTheme.headline6?.fontSize,
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
                          codePoint: selectedIcon,
                          onSelectedIcon: (codePoint) {
                            selectedIcon = codePoint;
                          },
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
      ),
    );
  }

  bool get isAddCategory => widget.category == null;

  bool get isBudgetActive => widget.category?.budget == null;

  AppBar appBar() {
    return materialYouAppBar(
      context,
      isAddCategory
          ? AppLocalizations.of(context)!.addCategoryLable
          : AppLocalizations.of(context)!.updateCategoryLable,
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
            ? AppLocalizations.of(context)!.addCategoryLable
            : AppLocalizations.of(context)!.updateLable,
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
      label: AppLocalizations.of(context)!.categoryLable,
      hintText: 'Enter category',
      validator: (value) {
        if (value!.length >= 3 && value.length < 10) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validNameLable;
        }
      },
    );
  }

  Widget _descriptionField() {
    return MaterialYouTextFeild(
      maxLength: 15,
      controller: descController,
      keyboardType: TextInputType.name,
      label: AppLocalizations.of(context)!.descriptionLable,
      hintText: 'Enter description',
    );
  }

  void _submitCategory() {
    if (formKey.currentState!.validate()) {
      if (selectedIcon != -1) {
        if (isAddCategory) {
          double? budget = 0;
          if (setBudget) {
            try {
              budget = double.tryParse(budgetController.text);
            } catch (_) {
              debugPrint(_.toString());
              return;
            }
          }

          addCategoryBloc.add(EditCategoryEvent(
            title: categoryController.text,
            description: descController.text,
            icon: selectedIcon,
            budget: budget,
          ));
        } else {
          double? budget = 0;
          if (setBudget) {
            try {
              budget = double.tryParse(budgetController.text);
            } catch (_) {
              debugPrint(_.toString());
              return;
            }
          }

          widget.category!
            ..description = descController.text
            ..name = categoryController.text
            ..icon = selectedIcon
            ..budget = budget
            ..save();
          showMaterialSnackBar(
            context,
            AppLocalizations.of(context)!.updatedCategoryLable,
          );
          context.pop();
        }
      } else {
        showMaterialSnackBar(
          context,
          AppLocalizations.of(context)!.selectCategoryIconLable,
        );
      }
    }
  }

  Widget _inputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectIconWidget(
          codePoint: selectedIcon,
          onSelectedIcon: (codePoint) {
            selectedIcon = codePoint;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _categoryField(),
              const SizedBox(height: 16),
              _descriptionField(),
              SetBudgetWidget(
                controller: budgetController,
                setBudget: setBudget,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  bool _checkBudget() {
    final double budget = widget.category?.budget ?? 0.0;
    if (budget > 0.0) {
      return true;
    }
    return false;
  }
}
