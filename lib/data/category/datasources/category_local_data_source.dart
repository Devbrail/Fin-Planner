import 'package:hive/hive.dart';

import '../../../common/enum/box_types.dart';
import '../../expense/model/expense.dart';
import '../model/category.dart';
import 'category_datasource.dart';

class CategoryLocalDataSources implements CategoryDataSource {
  late final box = Hive.box<Category>(BoxType.category.stringValue);

  @override
  Future<void> addCategory(Category category) async {
    final int id = await box.add(category);
    category.superId = id;
    category.save();
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

    await box.delete(key);
  }

  @override
  Future<List<Category>> categories() async {
    return box.values.toList();
  }

  @override
  Category fetchCategory(int categoryId) {
    final box = Hive.box<Category>(BoxType.category.stringValue);
    return box.values.firstWhere((element) => element.key == categoryId);
  }
}
