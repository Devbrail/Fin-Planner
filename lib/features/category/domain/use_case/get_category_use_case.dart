import 'package:injectable/injectable.dart';
import 'package:paisa/core/extensions/category_extension.dart';
import 'package:paisa/features/category/domain/entities/category.dart';
import 'package:paisa/features/category/domain/repository/category_repository.dart';

@singleton
class GetCategoryUseCase {
  GetCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Category? call(int categoryId) =>
      categoryRepository.fetchCategoryFromId(categoryId)?.toEntity();
}
