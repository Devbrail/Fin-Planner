import 'package:injectable/injectable.dart';
import 'package:paisa/features/category/domain/repository/category_repository.dart';

@singleton
class DeleteCategoryUseCase {
  DeleteCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Future<void> call(int key) => categoryRepository.deleteCategory(key);
}
