import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../model/category_model.dart';
import 'category_local_data_source.dart';

@Singleton(as: LocalCategoryManagerDataSource)
class LocalCategoryManagerDataSourceImpl
    implements LocalCategoryManagerDataSource {
  final Box<CategoryModel> categoryBox;

  LocalCategoryManagerDataSourceImpl(this.categoryBox);

  @override
  Future<void> addCategory(CategoryModel category) async {
    final int id = await categoryBox.add(category);
    category.superId = id;
    await category.save();
  }

  @override
  Future<void> deleteCategory(int key) async {
    await categoryBox.delete(key);
  }

  @override
  Future<List<CategoryModel>> categories() async {
    return categoryBox.values.toList();
  }

  @override
  CategoryModel? fetchCategoryFromId(int categoryId) =>
      categoryBox.values.firstWhereOrNull(
        (element) => element.key == categoryId,
      );

  @override
  Iterable<CategoryModel> exportData() => categoryBox.values;
}
