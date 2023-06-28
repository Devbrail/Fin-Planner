import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/data/category/data_sources/default_category.dart';

import '../model/category_model.dart';
import 'category_local_data_source.dart';

@Singleton(as: LocalCategoryDataManager)
class LocalCategoryManagerDataSourceImpl implements LocalCategoryDataManager {
  LocalCategoryManagerDataSourceImpl(this.categoryBox);

  final Box<CategoryModel> categoryBox;

  @override
  Future<void> addCategory(CategoryModel category) async {
    final int id = await categoryBox.add(category);
    category.superId = id;
    await category.save();
  }

  @override
  List<CategoryModel> categories() {
    return categoryBox.values.toList();
  }

  @override
  Map<dynamic, CategoryModel> categoriesMap() {
    return categoryBox.toMap();
  }

  @override
  Future<void> clearAll() => categoryBox.clear();

  @override
  Future<void> defaultCategories() async {
    defaultCategoriesData().forEach((element) async {
      await addCategory(element);
    });
  }

  @override
  Future<void> deleteCategory(int key) async {
    await categoryBox.delete(key);
  }

  @override
  Iterable<CategoryModel> exportData() => categoryBox.values;

  @override
  CategoryModel? fetchCategoryFromId(int categoryId) =>
      categoryBox.values.firstWhereOrNull(
        (element) => element.superId == categoryId,
      );

  @override
  Future<void> updateCategory(CategoryModel categoryModel) {
    return categoryBox.put(categoryModel.superId!, categoryModel);
  }
}
