import 'package:injectable/injectable.dart';

import '../repository/category_repository.dart';

@injectable
class DeleteCategoryUseCase {
  final CategoryRepository categoryRepository;

  DeleteCategoryUseCase({required this.categoryRepository});

  Future<void> call(int key) => categoryRepository.deleteCategory(key);
}
