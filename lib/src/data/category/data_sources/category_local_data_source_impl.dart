import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.dart';
import '../../expense/model/expense.dart';
import '../model/category.dart';
import 'category_local_data_source.dart';

@Singleton(as: LocalCategoryManagerDataSource)
class LocalCategoryManagerDataSourceImpl
    implements LocalCategoryManagerDataSource {
  final Box<Category> categoryBox;

  LocalCategoryManagerDataSourceImpl(this.categoryBox);

  @override
  Future<void> addCategory(Category category) async {
    final int id = await categoryBox.add(category);
    category.superId = id;
    await category.save();
  }

  @override
  Future<void> deleteCategory(int key) async {
    final expenseBox = getIt.get<Box<Expense>>();
    final keys = expenseBox.values
        .where((element) => element.categoryId == key)
        .map((e) => e.key)
        .toList();
    await expenseBox.deleteAll(keys);

    await categoryBox.delete(key);
  }

  @override
  Future<List<Category>> categories() async {
    return categoryBox.values.toList();
  }

  @override
  Category? fetchCategoryFromId(int categoryId) =>
      categoryBox.values.firstWhereOrNull(
        (element) => element.key == categoryId,
      );

  @override
  Iterable<Category> exportData() => categoryBox.values;
}
