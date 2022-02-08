import '../../../domain/category/repository/category_repository.dart';
import '../datasources/category_datasource.dart';
import '../model/category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource dataSources;

  CategoryRepositoryImpl({required this.dataSources});

  @override
  Future<List<Category>> categories() async {
    final categories = await dataSources.categories();
    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  @override
  Future<void> deleteCategory(int key) async {
    await dataSources.deleteCategory(key);
  }

  @override
  Future<void> addCategory({
    required String name,
    required String desc,
    required int icon,
    bool isPredefined = false,
  }) async {
    await dataSources.addCategory(Category(
      description: desc,
      name: name,
      icon: icon,
      isPredefined: isPredefined,
    ));
  }

  @override
  Future<void> updateCategory(Category category) async {
    await dataSources.addCategory(category);
  }
}
