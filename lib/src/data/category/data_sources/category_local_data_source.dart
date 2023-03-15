import '../model/category.dart';

abstract class LocalCategoryManagerDataSource {
  Future<void> addCategory(Category category);
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();
  Category fetchCategoryFromId(int categoryId);
  Iterable<Category> exportData();
}
