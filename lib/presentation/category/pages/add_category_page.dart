import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../common/constants/theme.dart';
import '../../../common/constants/util.dart';
import '../../../common/widgets/material_you_app_bar_widget.dart';
import '../../../common/widgets/material_you_card_widget.dart';
import '../../../common/widgets/material_you_textfield.dart';
import '../../../data/category/datasources/category_local_data_source.dart';
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

  late final categoryController =
      TextEditingController(text: widget.category?.name ?? '');
  late final descController =
      TextEditingController(text: widget.category?.description ?? '');

  late int selectedIcon = widget.category?.icon ?? -1;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: addCategoryBloc,
      listener: (context, state) {
        if (state is CategoryAddedState) {
          showMaterialSnackBar(
            context,
            isAddCategory
                ? AppLocalizations.of(context)!.successAddCategory
                : AppLocalizations.of(context)!.updatedCategory,
          );
          Navigator.pop(context);
        }
      },
      child: ScreenTypeLayout(
        mobile: Scaffold(
          appBar: appBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialYouCard(
                      child: CategoryIcons(onSeleted: (icon) {
                        selectedIcon = icon.codePoint;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _categoryField(),
                          const SizedBox(height: 16),
                          _descriptionField(),
                        ],
                      ),
                    ),
                  ),
                ],
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
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryIcons(onSeleted: (icon) {
                      selectedIcon = icon.codePoint;
                    }),
                  ),
                ),
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

  AppBar appBar() {
    return materialYouAppBar(
      context,
      AppLocalizations.of(context)!.addCategory,
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (selectedIcon != -1) {
            if (isAddCategory) {
              addCategoryBloc.add(EditCategoryEvent(
                title: categoryController.text,
                description: descController.text,
                icon: selectedIcon,
              ));
            } else {
              widget.category!
                ..description = descController.text
                ..name = categoryController.text
                ..icon = selectedIcon
                ..save();
            }
          } else {
            showMaterialSnackBar(
              context,
              AppLocalizations.of(context)!.selectCategoryIcon,
            );
          }
        }
      },
      child: Text(
        AppLocalizations.of(context)!.addCategory,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: context.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }

  Widget _categoryField() {
    return MaterialYouTextFeild(
      controller: categoryController,
      keyboardType: TextInputType.name,
      hintText: AppLocalizations.of(context)!.category,
      validator: (value) {
        if (value!.length >= 3) {
          return null;
        } else {
          return AppLocalizations.of(context)!.validName;
        }
      },
    );
  }

  Widget _descriptionField() {
    return MaterialYouTextFeild(
      controller: descController,
      keyboardType: TextInputType.name,
      hintText: AppLocalizations.of(context)!.description,
    );
  }
}

class CategoryIcons extends StatefulWidget {
  const CategoryIcons({
    Key? key,
    required this.onSeleted,
  }) : super(key: key);

  final Function(IconData iconData) onSeleted;

  @override
  _CategoryIconsState createState() => _CategoryIconsState();
}

class _CategoryIconsState extends State<CategoryIcons> {
  IconData selectedIcon = Icons.fastfood_rounded;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: categoryIcons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        var iconData = categoryIcons[index];
        return ScreenTypeLayout(
          mobile: IconButton(
            onPressed: () async {
              /* if (index == categoryIcons.length - 1) {
                final icon = await FlutterIconPicker.showIconPicker(
                  context,
                  iconPackModes: [IconPack.material],
                  searchIcon: const Icon(Icons.search_rounded),
                  iconPickerShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
                if (icon != null) {
                  selectedIcon = icon;
                  widget.onSeleted(selectedIcon);
                  setState(() {});
                }
                return;
              } */
              selectedIcon = iconData;
              widget.onSeleted(iconData);
              setState(() {});
            },
            icon: Icon(
              iconData,
              color: selectedIcon == iconData
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
          tablet: Card(
            shape: selectedIcon == iconData
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  )
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIcon = iconData;
                });
                widget.onSeleted(iconData);
              },
              child: Icon(
                iconData,
                size: 32,
                color: selectedIcon == iconData
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
