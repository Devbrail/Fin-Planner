import '../../../domain/category/repository/category_repository.dart';
import '../data_sources/category_local_data_source.dart';
import '../model/category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final LocalCategoryManagerDataSource dataSources;

  CategoryRepositoryImpl({required this.dataSources});

  @override
  Future<void> deleteCategory(int key) => dataSources.deleteCategory(key);

  @override
  Future<void> addCategory({
    required String name,
    required int icon,
    required int color,
    String? desc,
    bool isBudget = false,
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
  Future<Category?> fetchCategoryFromId(int categoryId) =>
      dataSources.fetchCategoryFromId(categoryId);
}
