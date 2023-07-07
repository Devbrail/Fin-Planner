import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/category/repository/category_repository.dart';
import '../../expense/data_sources/local_expense_data_manager.dart';
import '../data_sources/category_local_data_source.dart';
import '../model/category_model.dart';

@Singleton(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({
    required this.dataSources,
    required this.expenseDataManager,
    @Named('settings') required this.settings,
  });

  final CategoryLocalDataManager dataSources;
  final ExpenseLocalDataManager expenseDataManager;
  final Box<dynamic> settings;

  @override
  Future<void> addCategory({
    required String name,
    required int icon,
    required int color,
    String? desc,
    bool isBudget = false,
    double? budget = -1,
    bool isDefault = false,
  }) {
    return dataSources.add(CategoryModel(
      description: desc ?? '',
      name: name,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      color: color,
      isDefault: isDefault,
    ));
  }

  @override
  Future<void> clearAll() => dataSources.clear();

  @override
  Future<void> deleteCategory(int key) => dataSources.delete(key);

  @override
  CategoryModel? fetchCategoryFromId(int categoryId) =>
      dataSources.findById(categoryId);

  @override
  Future<void> updateCategory({
    required int key,
    required String name,
    required int icon,
    required int color,
    String? desc,
    double? budget = -1,
    bool isBudget = false,
  }) {
    return dataSources.update(CategoryModel(
      description: desc ?? '',
      name: name,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      color: color,
      superId: key,
    ));
  }

  @override
  List<CategoryModel> defaultCategories() {
    return dataSources.defaultCategories();
  }
}
