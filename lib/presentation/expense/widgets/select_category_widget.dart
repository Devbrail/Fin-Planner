import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../app/routes.dart';
import '../../../data/category/model/category.dart';
import '../../../di/service_locator.dart';
import '../../category/bloc/category_bloc.dart';

class SelectCategoryIcon extends StatefulWidget {
  const SelectCategoryIcon({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(Category) onSelected;

  @override
  _SelectCategoryIconState createState() => _SelectCategoryIconState();
}

class _SelectCategoryIconState extends State<SelectCategoryIcon> {
  final CategoryBloc addCategoryBloc = locator.get();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Category>>(
      valueListenable: Hive.box<Category>('category').listenable(),
      builder: (context, value, child) {
        final categories = value.values.toList();
        if (categories.isEmpty) {
          return ListTile(
            onTap: () => Navigator.pushNamed(context, addCategoryScreen),
            title: Text(AppLocalizations.of(context)!.addCategory),
            subtitle: Text(AppLocalizations.of(context)!.noCategory),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }
        widget.onSelected(categories[selectedIndex]);
        return ScreenTypeLayout(
          tablet: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.selectCategory,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              SelectedItem(
                categories: categories,
                onSelected: (index) {
                  selectedIndex = index;
                  widget.onSelected(categories[index]);
                  setState(() {});
                },
                selectedIndex: selectedIndex,
              )
            ],
          ),
          mobile: ListTile(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                context: context,
                builder: (_) {
                  return SafeArea(
                    maintainBottomViewPadding: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context)!.selectCategory,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SelectedItem(
                          categories: categories,
                          onSelected: (index) {
                            selectedIndex = index;
                            widget.onSelected(categories[index]);
                            setState(() {});
                          },
                          selectedIndex: selectedIndex,
                        )
                      ],
                    ),
                  );
                },
              );
            },
            title: Text(
              AppLocalizations.of(context)!.selectCategory,
            ),
            subtitle: Text(
              categories[selectedIndex].name,
            ),
          ),
        );
      },
    );
  }
}

class SelectedItem extends StatefulWidget {
  const SelectedItem({
    Key? key,
    required this.categories,
    required this.onSelected,
    required this.selectedIndex,
  }) : super(key: key);

  final List<Category> categories;
  final Function(int) onSelected;
  final int selectedIndex;

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 16,
          left: 16,
          right: 16,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (_, index) {
          final category = widget.categories[index];
          return AspectRatio(
            aspectRatio: 10 / 14,
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              clipBehavior: Clip.antiAlias,
              shape: selectedIndex == index
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    )
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
              child: InkWell(
                onTap: () {
                  selectedIndex = index;
                  widget.onSelected(selectedIndex);
                  setState(() {});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          IconData(
                            category.icon,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
