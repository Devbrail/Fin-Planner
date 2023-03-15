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
  Category? fetchCategoryFromId(int categoryId);
}
