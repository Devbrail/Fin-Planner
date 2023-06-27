import 'package:injectable/injectable.dart';

import '../entities/category.dart';
import '../repository/category_repository.dart';

@singleton
class UpdateCategoryUseCase {
  UpdateCategoryUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Future<void> call(Category category) async =>
      categoryRepository.updateCategory(
        key: category.superId!,
        color: category.color!,
        icon: category.icon,
        name: category.name,
        budget: category.budget,
        desc: category.description,
        isBudget: category.isBudget,
      );
}
