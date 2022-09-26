import '../model/category.dart';

abstract class CategoryLocalDataSource {
  Future<void> addCategory(Category category);
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();
  Category fetchCategory(int categoryId);
  Future<Category?> fetchCategoryFromId(int categoryId);
  Future<Iterable<Category>> exportData();
}
