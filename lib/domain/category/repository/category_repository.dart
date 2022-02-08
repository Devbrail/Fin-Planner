import '../../../data/category/model/category.dart';

abstract class CategoryRepository {
  Future<void> addCategory({
    required String name,
    required String desc,
    required int icon,
    bool isPredefined = false,
  });
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();

  Future<void> updateCategory(Category category);
}
