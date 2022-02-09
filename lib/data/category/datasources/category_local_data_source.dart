import 'package:flutter/material.dart';
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

List<IconData> categoryIcons = [
  Icons.home,
  Icons.receipt,
  Icons.checkroom,
  Icons.restaurant,
  Icons.medication,
  Icons.paid_outlined,
  Icons.sports_tennis,
  Icons.cable,
  Icons.local_gas_station,
  Icons.more_horiz,
];
/* 
List<Category> _predefinedCategories() {
  return [
    Category(
      description: '',
      name: 'Bills',
      icon: Icons.receipt.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Lifestyle',
      icon: Icons.checkroom.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Food',
      icon: Icons.restaurant.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Heatlh',
      icon: Icons.medication.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Home',
      icon: Icons.home.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Sports',
      icon: Icons.sports_tennis.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Electronics',
      icon: Icons.cable.codePoint,
      isPredefined: true,
    ),
    Category(
      description: '',
      name: 'Gas',
      icon: Icons.local_gas_station.codePoint,
      isPredefined: true,
    ),
  ];
}
 */