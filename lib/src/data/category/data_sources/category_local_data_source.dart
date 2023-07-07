import '../model/category_model.dart';

abstract class CategoryLocalDataManager {
  Future<void> add(CategoryModel category);

  Future<void> delete(int key);

  Future<List<CategoryModel>> categories();

  CategoryModel? findById(int categoryId);

  Iterable<CategoryModel> export();

  Future<void> update(CategoryModel categoryModel);

  Future<void> clear();

  List<CategoryModel> defaultCategories();
}
