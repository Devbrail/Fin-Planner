import '../model/category_model.dart';

abstract class LocalCategoryDataManager {
  Future<void> addCategory(CategoryModel category);

  Future<void> deleteCategory(int key);

  List<CategoryModel> categories();

  CategoryModel? fetchCategoryFromId(int categoryId);

  Iterable<CategoryModel> exportData();

  Future<void> updateCategory(CategoryModel categoryModel);

  Future<void> clearAll();

  Future<void> defaultCategories();
  Map<dynamic, CategoryModel> categoriesMap();
}
