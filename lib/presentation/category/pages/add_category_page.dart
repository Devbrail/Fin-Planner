import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/util.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../common/widgets/material_you_textfield.dart';
import '../../../common/widgets/show_icon_picker.dart';
import '../../../data/category/model/category.dart';
import '../../../di/service_locator.dart';
import '../bloc/category_bloc.dart';

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
  late int selectedIcon = widget.category?.icon ?? Icons.home_rounded.codePoint;
  late bool setBudget = widget.category?.budget == 0.0;

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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title:
                            Text(AppLocalizations.of(context)!.selectIconLable),
                        subtitle: Text(
                            AppLocalizations.of(context)!.selectIconDescLable),
                        leading: Icon(
                          IconData(
                            selectedIcon,
                            fontFamily: 'MaterialIcons',
                          ),
                        ),
                        onTap: () async {
                          final IconData? icon = await showIconPicker(
                            context: context,
                            defaultIcon: IconData(
                              selectedIcon,
                              fontFamily: 'MaterialIcons',
                            ),
                          );
                          setState(() {
                            selectedIcon =
                                icon?.codePoint ?? Icons.home_rounded.codePoint;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _categoryField()),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _descriptionField(),
                      _setBudget(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
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
          appBar: appBar(),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _categoryField(),
                          const SizedBox(height: 16),
                          _descriptionField(),
                          const SizedBox(height: 16),
                          _submitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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

  Widget _setBudget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.setBudgetLable),
          onChanged: (bool value) {
            setState(() {
              setBudget = value;
            });
          },
          value: setBudget,
        ),
        setBudget
            ? TextField(
                controller: budgetController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.budgetLable,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
