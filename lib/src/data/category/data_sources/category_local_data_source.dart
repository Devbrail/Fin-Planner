import '../model/category_model.dart';

abstract class LocalCategoryManagerDataSource {
  Future<void> addCategory(CategoryModel category);
  Future<void> deleteCategory(int key);
  Future<List<CategoryModel>> categories();
  CategoryModel? fetchCategoryFromId(int categoryId);
  Iterable<CategoryModel> exportData();
}
