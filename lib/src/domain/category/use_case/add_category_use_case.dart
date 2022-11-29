import 'package:flutter_paisa/src/domain/category/repository/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository categoryRepository;

  AddCategoryUseCase(this.categoryRepository);

  Future<void> addCategory({
    required String name,
    required String? desc,
    required int icon,
    double? budget = -1,
    required bool isBudget,
    required int color,
  }) async {
    categoryRepository.addCategory(
      name: name,
      desc: desc,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      color: color,
    );
  }
}
