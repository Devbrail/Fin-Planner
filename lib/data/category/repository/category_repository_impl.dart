import '../../../domain/category/repository/category_repository.dart';
import '../data_sources/category_local_data_source.dart';
import '../model/category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryLocalDataSource dataSources;

  CategoryRepositoryImpl({required this.dataSources});

  @override
  Future<List<Category>> categories() async {
    final categories = await dataSources.categories();
    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  @override
  Future<void> deleteCategory(int key) => dataSources.deleteCategory(key);

  @override
  Future<void> addCategory({
    required String name,
    required String? desc,
    required int icon,
    required bool isBudget,
    required int color,
    double? budget = -1,
  }) =>
      dataSources.addCategory(Category(
        description: desc ?? '',
        name: name,
        icon: icon,
        budget: budget,
        isBudget: isBudget,
        color: color,
      ));

  @override
  Future<void> updateCategory(Category category) =>
      dataSources.addCategory(category);

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) =>
      dataSources.fetchCategoryFromId(categoryId);
}
