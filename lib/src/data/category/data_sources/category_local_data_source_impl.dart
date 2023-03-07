import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import '../../../../main.dart';

import '../../../service_locator.dart';
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
  Category fetchCategory(int categoryId) =>
      categoryBox.values.firstWhere((element) => element.key == categoryId);

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) async =>
      categoryBox.get(categoryId);

  @override
  Future<Iterable<Category>> exportData() async => categoryBox.values;
}
