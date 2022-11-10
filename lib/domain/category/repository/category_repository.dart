import '../../../data/category/model/category.dart';

abstract class CategoryRepository {
  Future<void> addCategory({
    required String name,
    required String? desc,
    required int icon,
    double? budget = -1,
    required bool isBudget,
    required int color,
  });
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();

  Future<void> updateCategory(Category category);

  Future<Category?> fetchCategoryFromId(int categoryId);
}
