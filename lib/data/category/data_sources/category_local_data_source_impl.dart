import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../../expense/model/expense.dart';
import '../model/category.dart';
import 'category_local_data_source.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  late final categoryBox = Hive.box<Category>(BoxType.category.stringValue);

  @override
  Future<void> addCategory(Category category) async {
    final int id = await categoryBox.add(category);
    category.superId = id;
    await category.save();
  }

  @override
  Future<void> deleteCategory(int key) async {
    final expenseBox = Hive.box<Expense>('expense');
    final values = expenseBox.values.toList();
    final keys = values
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
  Category fetchCategory(int categoryId) {
    final box = Hive.box<Category>(BoxType.category.stringValue);
    return box.values.firstWhere((element) => element.key == categoryId);
  }

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) async =>
      categoryBox.get(categoryId);
  @override
  Future<Iterable<Category>> exportData() async => categoryBox.values;
}
