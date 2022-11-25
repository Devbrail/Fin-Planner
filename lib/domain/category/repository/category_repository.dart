import '../../../data/category/model/category.dart';

abstract class CategoryRepository {
  Future<void> addCategory({
    required String name,
    required int icon,
    required int color,
    String? desc,
    double? budget = -1,
    bool isBudget = false,
  });
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();

  Future<void> updateCategory(Category category);

  Future<Category?> fetchCategoryFromId(int categoryId);
}
