import '../model/category.dart';

abstract class CategoryDataSource {
  Future<void> addCategory(Category category);
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();
  Category fetchCategory(int categoryId);
}
