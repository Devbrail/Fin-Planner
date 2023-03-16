import '../../../data/category/model/category_model.dart';

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
  CategoryModel? fetchCategoryFromId(int categoryId);
}
