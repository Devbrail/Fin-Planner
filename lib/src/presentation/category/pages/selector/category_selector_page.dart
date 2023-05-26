import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../main.dart';
import '../../../../app/routes.dart';
import '../../../../core/common.dart';
import '../../../../core/enum/box_types.dart';
import '../../../../data/category/data_sources/category_local_data_source.dart';
import '../../../../data/category/data_sources/default_category.dart';
import '../../../../data/category/model/category_model.dart';
import '../../../widgets/paisa_big_button_widget.dart';
import '../../../widgets/paisa_card.dart';

class CategorySelectorPage extends StatefulWidget {
  const CategorySelectorPage({super.key});

  @override
  State<CategorySelectorPage> createState() => _CategorySelectorPageState();
}

class _CategorySelectorPageState extends State<CategorySelectorPage> {
  final List<CategoryModel> defaultModels = defaultCategoriesData();
  final LocalCategoryManagerDataSource dataSource = getIt.get();
  final settings = getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.materialYouAppBar(context.loc.categories),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PaisaBigButton(
            onPressed: () async {
              context.go(accountSelectorPath);
              await settings.put(userCategorySelectorKey, false);
            },
            title: context.loc.done,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
        builder: (context, value, child) {
          final List<CategoryModel> categoryModels = value.values.toList();
          return ListView(
            children: [
              ListTile(
                title: Text(
                  context.loc.addedCategories,
                  style: GoogleFonts.outfit(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              PaisaFilledCard(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryModels.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final CategoryModel model = categoryModels[index];
                    return ListTile(
                      onTap: () async {
                        await model.delete();
                        defaultModels.add(model);
                      },
                      leading: Icon(
                        IconData(
                          model.icon,
                          fontFamily: 'Material Design Icons',
                          fontPackage: 'material_design_icons_flutter',
                        ),
                        color:
                            Color(model.color ?? Colors.brown.shade200.value),
                      ),
                      title: Text(model.name),
                      trailing: const Icon(MdiIcons.delete),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(
                  context.loc.defaultCategories,
                  style: GoogleFonts.outfit(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: defaultModels
                      .map((model) => FilterChip(
                            label: Text(model.name),
                            onSelected: (value) {
                              dataSource.addCategory(model);
                              setState(() {
                                defaultModels.remove(model);
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            showCheckmark: false,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            padding: const EdgeInsets.all(12),
                            avatar: Icon(
                              IconData(
                                model.icon,
                                fontFamily: 'Material Design Icons',
                                fontPackage: 'material_design_icons_flutter',
                              ),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
