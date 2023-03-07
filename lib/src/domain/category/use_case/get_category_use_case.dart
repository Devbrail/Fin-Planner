import 'package:injectable/injectable.dart';

import '../../../data/category/model/category.dart';
import '../repository/category_repository.dart';

@injectable
class GetCategoryUseCase {
  final CategoryRepository categoryRepository;

  GetCategoryUseCase({required this.categoryRepository});

  Future<Category?> call(int categoryId) =>
      categoryRepository.fetchCategoryFromId(categoryId);
}
