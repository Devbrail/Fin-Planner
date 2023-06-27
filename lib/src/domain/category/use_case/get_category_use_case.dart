import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../entities/category.dart';
import '../repository/category_repository.dart';

@singleton
class GetCategoryUseCase {
  GetCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Category? call(int categoryId) =>
      categoryRepository.fetchCategoryFromId(categoryId)?.toEntity();
}
