import '../../../data/category/model/category.dart';
import '../repository/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepository;

  CategoryUseCase({required this.categoryRepository});

  Future<void> addCategory({
    required String name,
    required String? desc,
    required int icon,
    double? budget = -1,
    required bool isBudget,
    required int color,
  }) async {
    categoryRepository.addCategory(
      name: name,
      desc: desc,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      color: color,
    );
  }

  Future<List<Category>> categories() => categoryRepository.categories();

  Future<void> deleteCategory(int key) =>
      categoryRepository.deleteCategory(key);

  Future<void> updateCategory(Category category) =>
      categoryRepository.updateCategory(category);

  Future<Category?> fetchCategoryFromId(int categoryId) =>
      categoryRepository.fetchCategoryFromId(categoryId);
}
