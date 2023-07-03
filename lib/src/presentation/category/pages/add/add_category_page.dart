import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paisa/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/common.dart';
import '../../../widgets/paisa_big_button_widget.dart';
import '../../../widgets/paisa_color_picker.dart';
import '../../../widgets/paisa_text_field.dart';
import '../../bloc/category_bloc.dart';
import '../../widgets/category_icon_picker_widget.dart';
import '../../widgets/color_picker_widget.dart';
import '../../widgets/set_budget_widget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({
    Key? key,
    this.categoryId,
    this.isDefault,
  }) : super(key: key);

  final String? categoryId;
  final bool? isDefault;

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final CategoryBloc categoryBloc = getIt.get();
  final budgetController = TextEditingController();
  final categoryController = TextEditingController();
  final descController = TextEditingController();
  late final bool isAddCategory = widget.categoryId == null;

  @override
  void dispose() {
    budgetController.dispose();
    categoryController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    categoryBloc.isDefault = widget.isDefault ?? false;
    categoryBloc.add(FetchCategoryFromIdEvent(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoryBloc,
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryAddedState) {
            context.showMaterialSnackBar(
              isAddCategory
                  ? context.loc.successAddCategory
                  : context.loc.updatedCategory,
              backgroundColor: context.primaryContainer,
              color: context.onPrimaryContainer,
            );
            context.pop();
          } else if (state is CategoryErrorState) {
            context.showMaterialSnackBar(
              state.errorString,
              backgroundColor: context.errorContainer,
              color: context.onErrorContainer,
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

            descController.text = state.category.description ?? '';
            descController.selection = TextSelection.collapsed(
              offset: state.category.description?.length ?? 0,
            );
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout(
            mobile: Scaffold(
              appBar: context.materialYouAppBar(
                isAddCategory
                    ? context.loc.addCategory
                    : context.loc.updateCategory,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CategoryIconPickerWidget(),
                      SetBudgetWidget(controller: budgetController),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onTap: () {
                          paisaColorPicker(context,
                                  defaultColor:
                                      BlocProvider.of<CategoryBloc>(context)
                                              .selectedColor ??
                                          Colors.red.value)
                              .then((color) {
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CategoryColorSelectedEvent(color));
                          });
                        },
                        leading: Icon(
                          Icons.color_lens,
                          color: context.primary,
                        ),
                        title: Text(context.loc.pickColor),
                        subtitle: Text(context.loc.pickColorDesc),
                        trailing: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(BlocProvider.of<CategoryBloc>(context)
                                    .selectedColor ??
                                Colors.red.value),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16),
                            CategoryNameWidget(controller: categoryController),
                            const SizedBox(height: 16),
                            CategoryDescriptionWidget(
                                controller: descController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PaisaBigButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }

                      BlocProvider.of<CategoryBloc>(context)
                          .add(AddOrUpdateCategoryEvent(isAddCategory));
                    },
                    title: isAddCategory ? context.loc.add : context.loc.update,
                  ),
                ),
              ),
            ),
            tablet: Scaffold(
              appBar: context.materialYouAppBar(
                isAddCategory
                    ? context.loc.addCategory
                    : context.loc.updateCategory,
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PaisaBigButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }

                      BlocProvider.of<CategoryBloc>(context)
                          .add(AddOrUpdateCategoryEvent(isAddCategory));
                    },
                    title: isAddCategory ? context.loc.add : context.loc.update,
                  ),
                ),
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
                            const CategoryIconPickerWidget(),
                            SetBudgetWidget(controller: budgetController),
                            ColorPickerWidget(
                                categoryBloc:
                                    BlocProvider.of<CategoryBloc>(context)),
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
      hintText: context.loc.enterCategory,
      keyboardType: TextInputType.name,
      onChanged: (value) =>
          BlocProvider.of<CategoryBloc>(context).categoryTitle = value,
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return context.loc.validName;
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
      hintText: context.loc.enterDescription,
      keyboardType: TextInputType.name,
      onChanged: (value) =>
          BlocProvider.of<CategoryBloc>(context).categoryDesc = value,
    );
  }
}
