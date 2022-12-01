import '../../../data/category/model/category.dart';
import '../repository/category_repository.dart';

class GetCategoryUseCase {
  final CategoryRepository categoryRepository;

  GetCategoryUseCase({required this.categoryRepository});

  Future<Category?> execute(int categoryId) =>
      categoryRepository.fetchCategoryFromId(categoryId);
}
