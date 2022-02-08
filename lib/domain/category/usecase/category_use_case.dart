import '../../../data/category/model/category.dart';
import '../repository/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepository;

  CategoryUseCase({required this.categoryRepository});

  Future<void> addCategory({
    required String name,
    required String desc,
    required int icon,
    bool isPredefined = false,
  }) async {
    categoryRepository.addCategory(
      name: name,
      desc: desc,
      icon: icon,
      isPredefined: isPredefined,
    );
  }

  Future<List<Category>> categories() async {
    return categoryRepository.categories();
  }

  Future<void> deleteCategory(int key) async {
    return categoryRepository.deleteCategory(key);
  }

  Future<void> updateCategory(Category category) async {
    return categoryRepository.updateCategory(category);
  }
}
