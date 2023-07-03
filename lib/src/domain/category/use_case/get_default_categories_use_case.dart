import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../entities/category.dart';
import '../repository/category_repository.dart';

@singleton
class GetDefaultCategoriesUseCase {
  GetDefaultCategoriesUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  List<Category> call() => categoryRepository.defaultCategories().toEntities();
}
