import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../widgets/paisa_color_picker.dart';
import '../../../widgets/paisa_text_field.dart';
import '../../bloc/category_bloc.dart';
import '../../widgets/color_picker_widget.dart';
import '../../widgets/select_icon_widget.dart';
import '../../widgets/set_budget_widget.dart';

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
  late final categoryBloc = getIt.get<CategoryBloc>()
    ..add(FetchCategoryFromIdEvent(widget.categoryId));
  late TextEditingController budgetController = TextEditingController();
  late TextEditingController categoryController = TextEditingController();
  late TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    budgetController.dispose();
    categoryController.dispose();
    descController.dispose();
    super.dispose();
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
                  ? context.loc.successAddCategoryLabel
                  : context.loc.updatedCategoryLabel,
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

            descController.text = state.category.description ?? '';
            descController.selection = TextSelection.collapsed(
              offset: state.category.description?.length ?? 0,
            );
          }
        },
        builder: (context, state) {
          return ScreenTypeLayout.builder(
            mobile: (_) => Scaffold(
              appBar: appBar(),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SelectIconWidget(),
                      SetBudgetWidget(controller: budgetController),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onTap: () {
                          paisaColorPicker(context,
                                  defaultColor: categoryBloc.selectedColor ??
                                      Colors.red.value)
                              .then((color) {
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CategoryColorSelectedEvent(color));
                          });
                        },
                        leading: Icon(
                          Icons.color_lens,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(context.loc.pickColorLabel),
                        subtitle: Text(context.loc.pickColorDescLabel),
                        trailing: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                                categoryBloc.selectedColor ?? Colors.red.value),
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
                  child: _submitButton(context),
                ),
              ),
            ),
            tablet: (_) => Scaffold(
              appBar: context.materialYouAppBar(
                isAddCategory
                    ? context.loc.addCategoryLabel
                    : context.loc.updateCategoryLabel,
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
                            ColorPickerWidget(categoryBloc: categoryBloc),
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
                            _submitButton(context),
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
          ? context.loc.addCategoryLabel
          : context.loc.updateCategoryLabel,
    );
  }

  Widget _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final isValid = _formKey.currentState!.validate();
        if (!isValid) {
          return;
        }

        BlocProvider.of<CategoryBloc>(context)
            .add(AddOrUpdateCategoryEvent(isAddCategory));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(
        isAddCategory ? context.loc.addCategoryLabel : context.loc.updateLabel,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
        ),
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
      hintText: context.loc.enterCategoryLabel,
      label: context.loc.categoryLabel,
      keyboardType: TextInputType.name,
      onChanged: (value) =>
          BlocProvider.of<CategoryBloc>(context).categoryTitle = value,
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return context.loc.validNameLabel;
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
      hintText: context.loc.enterDescriptionLabel,
      keyboardType: TextInputType.name,
      label: context.loc.descriptionLabel,
      onChanged: (value) =>
          BlocProvider.of<CategoryBloc>(context).categoryDesc = value,
    );
  }
}
