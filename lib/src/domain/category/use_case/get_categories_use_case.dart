import 'package:injectable/injectable.dart';

import '../../../core/common.dart';
import '../entities/category.dart';
import '../repository/category_repository.dart';

@singleton
class GetCategoriesUseCase {
  GetCategoriesUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  List<Category> call() => categoryRepository.categories().toEntities();

  Map<int, Category> map() => categoryRepository.categoriesMap().toMap();
}
